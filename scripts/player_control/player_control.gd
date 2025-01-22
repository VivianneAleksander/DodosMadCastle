extends CharacterBody3D
class_name PlayerControl

const SPEED = 6.0
const JUMP_VELOCITY = 6.5
const BOUNCE_VELOCITY = 13.0
const DASH_VELOCITY = 8.0

const GRAV_LOW = 0.5
const GRAV_HIGH = 2.0
const GRAV_CURVE = 0.75

@onready var health_component : HealthComponent = $HealthComponent

var playerVelocity : Vector3
var airTimer : float
var inParry : bool
var manager : gameManager

func start_game(man):
	playerVelocity = Vector3.ZERO
	inParry = false
	manager = man

func reload_level():
	manager.reload_level()

func _physics_process(delta: float) -> void:
	if health_component.health <= 0:
		return
	
	# Add the gravity.
	if is_on_floor():
		airTimer = 0.0
		if playerVelocity.y < 0 :
			playerVelocity.y = 0.0
	else:
		airTimer += delta
		var grav = clamp(lerp(GRAV_LOW, GRAV_HIGH, airTimer / GRAV_CURVE),GRAV_LOW,GRAV_HIGH)
		playerVelocity.y += get_gravity().y * (grav) * delta

	if Input.is_action_just_pressed("ui_accept"):
		jump()
	
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		playerVelocity.x = direction.x * SPEED
		playerVelocity.z = direction.z * SPEED
	else:
		playerVelocity.x = move_toward(velocity.x, 0, SPEED)
		playerVelocity.z = move_toward(velocity.z, 0, SPEED)

	velocity = playerVelocity
	move_and_slide()
	
func jump():
	if is_on_floor(): 
		playerVelocity.y = JUMP_VELOCITY
		airTimer = 0.0

func bounce():
	playerVelocity.y = BOUNCE_VELOCITY
	airTimer = 0.0

func _on_hurt_box_area_entered(area):
	var enemy = area.get_parent() as EnemyBase
	var bullet = area.get_parent() as BulletBase
	
	if inParry:
		if bullet:
			bullet.set_alliance(true, false)
			bullet.bounce()
		return
	
	if !enemy:
		return
	if enemy.death_state == true:
		bounce()
		##enemy.pop_bubble()

func _on_game_ui_s_parry_start():
	inParry = true
	var collider = $CameraContainer/Camera3D/RayCast3D.get_collider()
	if !collider:
		return
	var enemy = collider.get_parent() as EnemyBase
	if !enemy:
		return
	if enemy.death_state == true:
		var midpoint = lerp(enemy.global_position, global_position, 0.5)
		global_position = midpoint
		var fwd = transform.basis * Vector3.FORWARD
		playerVelocity += fwd * DASH_VELOCITY
		enemy.push_bubble(fwd)
		bounce()
	
func _on_game_ui_s_parry_stop():
	inParry = false

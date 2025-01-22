extends CharacterBody3D
class_name EnemyBase

const SPEED = 5.0
const JUMP_VELOCITY = 4.5
const FLOAT_SPEED = 0.5
const PUSH_SPEED = 5.0
const BUBBLE_DRAG = 0.25

@onready var health_component : HealthComponent = $HealthComponent

var influences : Array[Vector3]
var death_state : bool = false
var enemyVel : Vector3

func _physics_process(delta: float) -> void:
	if death_state:
		_perform_death(delta)
		return
	
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	var combined_influence : Vector3 = Vector3.ZERO
	if influences.size() > 0:
		for i in influences:
			combined_influence += i
		combined_influence /= influences.size()
		influences.clear()
		
	var direction := (transform.basis * combined_influence).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()

func set_death_state(value : bool) -> void:
	death_state = value
	$PhysicsCollisionShape3D.disabled = true
	$Hitbox.monitorable = false
	$Hitbox.monitoring = false
	$BubbleBox.monitorable = true
	$BubbleBox.monitoring = true
	
func pop_bubble():
	queue_free()

func push_bubble(dir):
	enemyVel += dir * PUSH_SPEED
	enemyVel.y += FLOAT_SPEED

func _perform_death(_delta : float):
	enemyVel.y = move_toward(enemyVel.y, FLOAT_SPEED, _delta * BUBBLE_DRAG)
	enemyVel.x = move_toward(enemyVel.x, 0, _delta * BUBBLE_DRAG)
	enemyVel.z = move_toward(enemyVel.z, 0, _delta * BUBBLE_DRAG)
	velocity = enemyVel
	move_and_slide()

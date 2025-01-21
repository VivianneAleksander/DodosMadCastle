extends Node3D
class_name BulletBase

@onready var player_hitbox : DamageCollision3D = $PlayerHitbox
@onready var enemy_hitbox : DamageCollision3D = $EnemyHitbox

var direction : Vector3
var velocity : float
var damage : int :
	get():
		return player_hitbox.damage_value
	set(value):
		player_hitbox.damage_value = value
		enemy_hitbox.damage_value = value
var piercing : int
var pierced : int

enum ALLIANCE {
	PLAYER = 0,
	ENEMY = 1,
	NEUTRAL = 2,
	NONE = 3
}

func _ready() -> void:
	player_hitbox.area_entered.connect(deal_damage)
	enemy_hitbox.area_entered.connect(deal_damage)

func _physics_process(delta: float) -> void:
	global_position += direction * velocity * delta

func factory(args : BulletArgs) -> void:
	await get_tree().process_frame
	direction = args.direction.normalized()
	velocity = args.velocity
	damage = args.damage
	piercing = args.piercing
	global_position = args.origin
	
	match args.alliance:
		ALLIANCE.PLAYER:
			set_alliance(true, false)
		ALLIANCE.ENEMY:
			set_alliance(false, true)
		ALLIANCE.NEUTRAL:
			set_alliance(false, false)
		ALLIANCE.NONE:
			set_alliance(true, true)

func set_alliance(player : bool, enemy : bool):
	player_hitbox.monitorable = not player
	player_hitbox.monitoring = not player
	enemy_hitbox.monitorable = not enemy
	enemy_hitbox.monitoring = not enemy

func deal_damage(area : Area3D):
	if piercing >= 0:
		pierced += 1
	if pierced >= piercing:
		queue_free()

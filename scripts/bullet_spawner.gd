extends Node3D
class_name BulletSpawner

@export var bullet_prefab : PackedScene
@export var args : BulletArgs
@onready var temp_args := BulletArgs.make_copy(args)

func spawn_bullet() -> BulletBase:
	temp_args.direction = global_basis * args.direction
	temp_args.origin = global_position
	
	var new_bullet : BulletBase = bullet_prefab.instantiate() as BulletBase
	get_tree().root.add_child(new_bullet)
	new_bullet.factory(temp_args)
	new_bullet.global_position = global_position
	return new_bullet

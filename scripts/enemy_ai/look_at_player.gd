extends Node
class_name LookAtPlayer

@onready var player : CharacterBody3D = get_tree().get_nodes_in_group("player")[0] as CharacterBody3D
@onready var primary : Node3D = get_parent() as Node3D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	assert(player, "NO PLAYER FOUND: (" + name + ")")
	if not player:
		queue_free()
		
	assert(primary, "NO PRIMARY FOUND: (" + name + ")")
	if not primary:
		queue_free()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	primary.look_at(player.global_position)

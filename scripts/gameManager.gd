class_name gameManager
extends Node

@export var Player : PlayerControl
@export var Levels : Array[PackedScene]
var index : int = 0

var loaded_level

func _ready():
	loaded_level = null
	index = -1
	Player.start_game(self)
	load_next_level()

func reload_level():
	await get_tree().process_frame
	if loaded_level:
		loaded_level.queue_free()
		prep_level()

func load_next_level():
	if loaded_level:
		loaded_level.queue_free()
	index += 1
	if index > Levels.size():
		return
	
	prep_level()

func prep_level():
	get_tree().call_group("bullets", "queue_free")
	loaded_level = Levels[index].instantiate() as levelManager
	add_child(loaded_level)
	loaded_level.start_level(self)
	Player.global_position = loaded_level.PlayerStart.global_position
	Player.global_rotation = loaded_level.PlayerStart.global_rotation

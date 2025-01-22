class_name gameManager
extends Node

@export var Player : PlayerControl
@export var Levels : Array[PackedScene]
var index : int = 0

var loaded_level

func _ready():
	loaded_level = null
	index = -1
	load_next_level()

func reload_level():
	if loaded_level:
		loaded_level.queue_free()
	Levels[index].instantiate()

func load_next_level():
	if loaded_level:
		loaded_level.queue_free()
	index += 1
	if index > Levels.size():
		return
	loaded_level = Levels[index].instantiate() as levelManager
	add_child(loaded_level)
	loaded_level.start_level(self)
	Player.global_position = loaded_level.PlayerStart.global_position
	Player.global_rotation = loaded_level.PlayerStart.global_rotation

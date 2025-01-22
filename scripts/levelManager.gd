class_name levelManager
extends Node

@export var PlayerStart : Node
var manager : gameManager

func start_level(man):
	manager = man

func on_level_exit():
	manager.load_next_level()

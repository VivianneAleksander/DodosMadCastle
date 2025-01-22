extends Node3D

@export var game_scene : PackedScene

func _ready() -> void:
	if not game_scene:
		get_tree().quit()

func enter_game_animation():
	$AnimationPlayer.play("enter_text")

func enter_game_proper():
	var new_game_scene = game_scene.instantiate()
	get_tree().root.add_child(new_game_scene)
	queue_free()

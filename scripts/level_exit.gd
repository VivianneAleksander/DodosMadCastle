extends Node3D
class_name LevelExit

@export var enabled : bool = true

func _ready() -> void:
	set_enabled(enabled)
		

func _on_area_3d_area_entered(area):
	var player = area.get_parent() as PlayerControl
	if player:
		get_parent().on_level_exit()
		

func set_enabled(e : bool = true):
	enabled = e
	visible = e
	$Area3D.monitorable = e
	$Area3D.monitoring = e

extends Node3D
class_name LevelExit

func _on_area_3d_area_entered(area):
	var player = area.get_parent() as PlayerControl
	if player:
		get_parent().on_level_exit()

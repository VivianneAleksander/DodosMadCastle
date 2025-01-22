extends Node3D
class_name LevelExit

signal exited_level


func _on_area_3d_body_entered(body: Node3D) -> void:
	exited_level.emit()

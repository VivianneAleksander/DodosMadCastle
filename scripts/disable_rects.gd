extends Control
class_name DisableRects

@export var rects : Array[TextureRect]

@onready var number_enabled : int = rects.size()

func update_rects(n : int) -> void:
	if n < 0 or n >= rects.size():
		return
	
	number_enabled = n
	for i in rects.size():
		if i >= number_enabled:
			rects[i].modulate = Color(1, 1, 1, 0)
		else:
			rects[i].modulate = Color(1, 1, 1, 1)
			

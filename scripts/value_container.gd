extends AnimationValue
class_name ValueContainer

@export var value : bool = false

func _get_value() -> Variant:
	return value

func _set_value(new_value : bool) -> void:
	value = new_value

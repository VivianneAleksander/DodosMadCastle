extends AnimationValue
class_name InputValue

@export var action_name : String
@export_enum("PRESSED", "RELEASED", "JUST_PRESSED", "JUST_RELEASED") var trigger_when : int = 0

enum {
	PRESSED = 0,
	RELEASED = 1,
	JUST_PRESSED = 2,
	JUST_RELEASED = 3
}

func _get_value() -> Variant:
	if not InputMap.has_action(action_name):
		return false
	
	match trigger_when:
		PRESSED:
			return Input.is_action_pressed(action_name)
		RELEASED:
			return not Input.is_action_pressed(action_name)
		JUST_PRESSED:
			return Input.is_action_just_pressed(action_name)
		JUST_RELEASED:
			return Input.is_action_just_released(action_name)
	
	return false

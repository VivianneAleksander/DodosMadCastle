extends AnimationValue

@onready var target := $"../.." as CharacterBody3D
const deadzone : float = 0.015

func _get_value() -> Variant:
	return target.is_on_floor() and target.velocity.length() > deadzone

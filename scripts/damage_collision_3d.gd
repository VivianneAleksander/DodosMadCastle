extends Area3D
class_name DamageCollision3D

var damage_value : int = 1

signal damage_dealt

func _ready():
	area_entered.connect(_on_area_entered)

func _on_area_entered(area: Area3D):
	var health_component : HealthComponent
	var parent = area.get_parent()
	if "health_component" in area:
		health_component = area.health_component
	elif "health_component" in parent:
		health_component = parent.health_component
	else:
		return

	health_component.adjust_health(-damage_value)
	damage_dealt.emit()

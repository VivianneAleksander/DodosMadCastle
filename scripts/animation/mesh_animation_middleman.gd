extends Node3D
class_name MeshAnimationMiddleman

@onready var animation_tree : AnimationTree = $AnimationTree as AnimationTree
var property_path : String = "parameters/conditions/"

signal s_fire

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	assert(animation_tree, "NO ANIMATION_TREE FOUND UNDER (" + name + ")")

func _get_value(property : String) -> Variant:
	var path := property_path + property
	assert(path in animation_tree, "PROPERTY NOT FOUND: " + path + " (" + name + ")")
	return animation_tree.get(path)

func _set_value(property : String, new_value) -> void:
	var value = _get_value(property)
	
	var type_string_value := type_string(typeof(new_value))
	var type_string_current := type_string(typeof(value))
	assert(type_string_current == type_string_value, "MISMATCHED VALUE TYPE: " + type_string_current + ", " + type_string_value + " (" + name + ")")
	
	var path := property_path + property
	animation_tree.set(path, new_value)

func fire() -> void:
	s_fire.emit()

extends AnimationTree
class_name AnimationValuesManager

@onready var values : Array[AnimationValue] = []
@export var parameter_path_base : String = "parameters/StateMachine/conditions/"
@export var middlemen : Array[MeshAnimationMiddleman]
@export var middleman_blacklist : Array[String]

func _ready():
	values.assign(get_children())

func _process(delta):
	for v : AnimationValue in values:
		var value = v._get_value()
		self[parameter_path_base + v.value_name] = value
		update_middlemen(v.value_name, value)
		if v.also_set_inverse:
			self[parameter_path_base + v.value_name_inverse] = not value
			update_middlemen(v.value_name_inverse, not value)

func update_middlemen(property : String, value) -> void:
	if middleman_blacklist.has(property): return
	for m in middlemen:
		m._set_value(property, value)
	

extends Node
class_name FrictionApplicator

@onready var primary := get_parent()
@export var friction : float = 0.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if not primary or not "velocity" in primary:
		queue_free()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	primary.velocity = lerpf(primary.velocity, 0, friction * delta)

extends CharacterBody3D


const SPEED = 5.0
const JUMP_VELOCITY = 4.5


var influences : Array[Vector3]

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	var combined_influence : Vector3 = Vector3.ZERO
	if influences.size() > 0:
		for i in influences:
			combined_influence += i
		combined_influence /= influences.size()
		
	var direction := (transform.basis * combined_influence).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()

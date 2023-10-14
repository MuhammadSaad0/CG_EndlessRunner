extends CharacterBody3D

const SPEED = 50.0
const JUMP_VELOCITY = 8.5
const MOVE_DISTANCE = 500.0  # Define the fixed movement distance.

var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

func _physics_process(delta):
	if not is_on_floor():
		velocity.y -= gravity * delta * 1.7

	if Input.is_action_just_pressed("up") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	var input_dir = Vector3()  # Initialize the input direction as a zero vector.

	# Check for left and right inputs and set the appropriate x value in the input_dir vector.
	if Input.is_action_pressed("left"):
		input_dir.x = -MOVE_DISTANCE  # Move left by a fixed distance.
	elif Input.is_action_pressed("right"):
		input_dir.x = MOVE_DISTANCE  # Move right by a fixed distance.

	# Get the direction vector and normalize it.
	var direction = (transform.basis * input_dir).normalized()

	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()

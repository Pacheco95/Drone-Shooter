extends CharacterBody2D

@export var movement_velocity = 300
@export var deadzone = 0.1

func _process(_delta):
	var direction = Input.get_vector("left", "right", "up", "down")
	velocity = direction * movement_velocity
	move_and_slide()

	if direction.length() > deadzone:
		rotation_degrees = rad_to_deg(direction.angle()) + 90

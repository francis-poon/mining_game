class_name Player
extends CharacterBody2D

const SPEED = 30.0


func _physics_process(delta: float) -> void:
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_vector("move_left", "move_right", "move_up", "move_down")
	if direction:
		velocity = direction * SPEED 
	else:
		velocity = Vector2.ZERO

	move_and_slide()

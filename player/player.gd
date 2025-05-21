class_name Player
extends CharacterBody2D

@export var speed: float = 50


func _physics_process(delta: float) -> void:
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_vector("move_left", "move_right", "move_up", "move_down")
	if direction:
		velocity = direction * speed 
	else:
		velocity = Vector2.ZERO

	move_and_slide()

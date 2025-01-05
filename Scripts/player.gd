extends CharacterBody2D

@export var speed := 300.0

func _physics_process(delta: float) -> void:

	# Get the input direction and handle the movement/deceleration.
	
	#NOTE: get_axis treats move_up as negative and move_down as positive
	# move_up makes direction = -1, move_down makes direction = 1
	var direction := Input.get_axis("move_up", "move_down")
	
	velocity.y = direction * speed
	
	if direction != 0:
		print(direction)
		print(velocity)
	
	move_and_slide()
	
	

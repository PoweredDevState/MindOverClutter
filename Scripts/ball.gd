extends CharacterBody2D

@export var speed := 400.0
@export var acceleration := 20.0

var direction : Vector2

const MAX_Y_VECTOR := 0.6

func _ready() -> void:
	direction = random_starting_direction()

func _physics_process(delta: float) -> void:
	velocity = direction * speed
	var collision = move_and_collide(velocity * delta)
	
	if collision:
		#flips the sprite depending on where it is facing
		'''
		if direction.x > 0:
			$Sprite2D.flip_h = false
		else:
			$Sprite2D.flip_h = true
		'''
		
		#get the information of the collider
		var collider = collision.get_collider()
		
		#if the ball collides with the player, increase the speed with each collision
		if collider == $"../Player" or collider.collision_layer == 2:
			speed += acceleration
			#direction = new_direction(collider)
		
		if collider.collision_layer == 2:
			collider.reduce_strength()
			#direction = new_direction(collider)
		#else:
		
		direction = direction.bounce(collision.get_normal())


#randomly sets the angle of the ball will shoot at when the game starts
func random_starting_direction():
	var new_dir := Vector2(-1, randf_range(-0.9, 0.9))
	return new_dir.normalized()
	
func new_direction(collider):
	var ball_y = position.y
	var paddle_y = collider.position.y
	var distance = ball_y - paddle_y
	var new_dir := Vector2()
	
	#flip horizontal direction
	if direction.x > 0:
		new_dir.x = -1
	else:
		new_dir.x = 1
		
	new_dir.y = (distance / (collider.block_height / 2)) * MAX_Y_VECTOR
	
	return new_dir.normalized()

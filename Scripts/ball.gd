extends CharacterBody2D

@export var speed := 400.0
@export var acceleration := 20.0

var direction : Vector2

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
		
		#if the ball collides with the player, enemy, or block,
		#increase the speed with each collision
		
		#match statement method
		match collider.collision_layer:
			1, 4:
				speed += acceleration
				#direction = new_direction(collider)
			2:
				speed += acceleration
				collider.reduce_strength()
				
				
		'''
		#if statement method
		if (collider.collision_layer == 1 
			or collider.collision_layer == 2
			or collider.collision_layer == 4):
			speed += acceleration
			#direction = new_direction(collider)
		
		if collider.collision_layer == 2:
			collider.reduce_strength()
			#direction = new_direction(collider)
		'''
		
		
		direction = direction.bounce(collision.get_normal())


#randomly sets the angle of the ball will shoot at when the game starts
func random_starting_direction() -> Vector2:
	var new_dir := Vector2(-1, randf_range(-0.9, 0.9))
	return new_dir.normalized()
	

extends CharacterBody2D

@export var speed := 400.0
@export var acceleration := 20.0
@export var wall_acceleration := 5.0

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
		#NOTE: the collision_layer value is based on 
		#		the value stated when you hover on the layer
		#EX: Layer 5: Enemy | Bit 4 | Value 16
		#The value that must be checked for in the Enemy layer is 16
		match collider.collision_layer:
			#Player and Ball
			1, 8:
				SoundManager.create_pause_immune_sound_at_location(global_position, SoundResource.SOUND_TYPE.BALL_HIT)
				speed += acceleration
				#direction = new_direction(collider)

			#Block
			2:
				SoundManager.create_pause_immune_sound_at_location(global_position, SoundResource.SOUND_TYPE.BALL_HIT)
				speed += acceleration
				collider.reduce_strength()
				
			#Wall
			4:
				SoundManager.create_pause_immune_sound_at_location(global_position, SoundResource.SOUND_TYPE.BALL_HIT)
				speed += wall_acceleration

			#Enemy
			16:
				#print("Hit Enemy")
				speed += acceleration
				collider.reduce_health()
				
		#This changes the direction of the ball to the opposite direction
		direction = direction.bounce(collision.get_normal())


#randomly sets the angle of the ball will shoot at when the game starts
func random_starting_direction() -> Vector2:
	var newDir := Vector2(-1, randf_range(-0.9, 0.9))
	return newDir.normalized()
	

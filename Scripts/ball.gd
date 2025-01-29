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
		#NOTE: the collision_layer value is based on what is said
		#	   when you hover on the layer
		#EX: Layer 5: Enemy | Bit 4 | Value 16
		match collider.collision_layer:
			#Player and Ball
			1, 8:
				speed += acceleration
				#direction = new_direction(collider)

			#Block
			2:
				speed += acceleration
				collider.reduce_strength()

			#Enemy
			16:
				#print("Hit Enemy")
				speed += acceleration
				collider.reduce_health()
				
		direction = direction.bounce(collision.get_normal())


#randomly sets the angle of the ball will shoot at when the game starts
func random_starting_direction() -> Vector2:
	var newDir := Vector2(-1, randf_range(-0.9, 0.9))
	return newDir.normalized()
	

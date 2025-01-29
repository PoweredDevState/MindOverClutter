extends CharacterBody2D

@onready var playerRef := get_node("/root/Main2D/Player")
@export var speed : float = 200.0

#This function moves the object towards the player
#When this object collides with the player, 
#	call the set_shield() function inside of the player and delete this object
func _physics_process(delta: float) -> void:
	var direction = global_position.direction_to(playerRef.global_position)
	velocity = direction * speed
	var collision = move_and_collide(velocity * delta)
	
	if collision:
		
		#get the information of the collider
		var collider = collision.get_collider()
		
		#match statement method
		#NOTE: the collision_layer value is based on what is said
		#	   when you hover on the layer
		#EX: Layer 5: Enemy | Bit 4 | Value 16
		match collider.collision_layer:
			#Player
			1:
				collider.set_shield(true)
				queue_free()
	

extends Area2D

@onready var animPlayerRef := $AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	animPlayerRef.play("Explosion")

#This function is called when an object collides with this attack
#If the player collides with this attack, 
#	this calls the set_stun() fucntion inside of the player
func _on_body_entered(body: Node2D) -> void:
	match body.collision_layer:
		#Player
		1:
			#print("Hit Player")
			body.set_stun(true)

#This function is called when the animation is finished.
#This deletes the object from the world
func _on_animation_player_animation_finished(_anim_name: StringName) -> void:
	queue_free()

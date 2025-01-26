extends Area2D

@onready var animPlayerRef := $AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	animPlayerRef.play("Explosion")



func _on_body_entered(body: Node2D) -> void:
	match body.collision_layer:
		#Player
		1:
			#print("Hit Player")
			body.set_stun(true)


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	queue_free()

extends CharacterBody2D

@export var health := 3

func _ready() -> void:
	pass

func reduce_health() -> void:
	health -= 1
	
	#print(health)
	
	if health == 0:
		queue_free()

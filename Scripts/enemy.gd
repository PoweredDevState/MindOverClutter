extends CharacterBody2D

#For Health Management
var current_health : int
@export var max_health := 3
var health_percentage : float
signal health_changed

#For Attacking
var minAttackTransform : Vector2
var maxAttackTransform : Vector2

func _ready() -> void:
	current_health = max_health
	change_percentage()
	
	minAttackTransform = $"../StartAttackMark".position
	maxAttackTransform = $"../EndAttackMark".position

func reduce_health() -> void:
	current_health -= 1
	change_percentage()
	#print(current_health)
	
	if current_health == 0:
		queue_free()
		
func change_percentage() -> void:
	health_percentage = (float(current_health) / max_health) * 100
	health_changed.emit(health_percentage)

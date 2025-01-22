extends Node2D

@export var lives := 2
@export var balls_on_screen := 0

signal zero_balls_on_screen
signal lives_changed

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func add_ball():
	balls_on_screen += 1
	
func subtract_ball():
	balls_on_screen -= 1
	
	if balls_on_screen <= 0:
		lose_life()
		
func lose_life():
	lives -= 1
	
	if lives < 0:
		print("Lose")
	else:
		lives_changed.emit()
		zero_balls_on_screen.emit()

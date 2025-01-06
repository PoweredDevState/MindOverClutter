extends StaticBody2D

@export var block_strength : int
var block_color : Color
#var block_height : int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#block_height = $ColorRectForSizing.size.y
	change_block_color()
	
func reduce_strength():
	block_strength -= 1
	
	if block_strength == 0:
		queue_free()
	else:
		change_block_color()

func change_block_color():
	if block_strength == 1:
		block_color = Color.RED
	elif block_strength == 2:
		block_color = Color.YELLOW
	elif block_strength == 3:
		block_color = Color.GREEN
	else:
		block_color = Color.BLUE
		
	$Sprite2D.self_modulate = block_color

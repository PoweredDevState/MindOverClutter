extends StaticBody2D

var block_strength : int
var block_color : Color
var random_item_number : int

func _init() -> void:
	randomize_block_strength()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	change_block_color()
	
func reduce_strength():
	block_strength -= 1
	
	if block_strength == 0:
		drop_item()
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
	
func randomize_block_strength():
	block_strength = randi_range(1, 4)
	
func drop_item():
	random_item_number = randi_range(0, 10)
	
	if random_item_number >= 6 and random_item_number <= 8:
		$"../../../BallSpawner".spawn_ball_from_block(self.global_position)
	

extends StaticBody2D

var block_strength : int
var block_color : Color
var random_item_number : int

@export var shieldPowerUpScene : PackedScene
var shieldPowerUp : Object

func _init() -> void:
	randomize_block_strength()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	change_block_color()
	
func reduce_strength() -> void:
	block_strength -= 1
	
	if block_strength == 0:
		drop_item()
		queue_free()
	else:
		change_block_color()

func change_block_color() -> void:
	if block_strength == 1:
		block_color = Color.RED
	elif block_strength == 2:
		block_color = Color.YELLOW
	elif block_strength == 3:
		block_color = Color.GREEN
	else:
		block_color = Color.BLUE
		
	$Sprite2D.self_modulate = block_color
	
func randomize_block_strength() -> void:
	block_strength = randi_range(1, 4)
	
func drop_item() -> void:
	random_item_number = randi_range(0, 10)
	
	if random_item_number >= 6 and random_item_number <= 8:
		get_node("/root/Main2D/BallSpawner").spawn_ball_from_block(self.global_position)
	elif random_item_number >= 3 and random_item_number <= 5:
		spawn_shield()
	
func spawn_shield() -> void:
	shieldPowerUp = shieldPowerUpScene.instantiate()
	shieldPowerUp.global_position = self.global_position
	get_node("/root/Main2D").add_child.call_deferred(shieldPowerUp)
	

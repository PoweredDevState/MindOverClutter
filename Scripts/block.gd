extends StaticBody2D

var blockStrength : int
var blockColor : Color
var randomItemNumber : int

@export var shieldPowerUpScene : PackedScene
var shieldPowerUp : Object

@onready var spriteRef := $Sprite2D

func _init() -> void:
	randomize_block_strength()

func _ready() -> void:
	change_block_color()

#This function reduces the strength of the block.
#When the strength reaches 0, call the drop_item function 
#	and destroy the block
#This also calls the change_block_color function 
#	when there is still strength left
func reduce_strength() -> void:
	blockStrength -= 1
	
	if blockStrength == 0:
		drop_item()
		SoundManager.create_sound_at_location(global_position, SoundResource.SOUND_TYPE.BLOCK_DESTROYED)
		queue_free()
	else:
		change_block_color()

#This function changes the color of the sprite based on the blockStrength
func change_block_color() -> void:
	if blockStrength == 1:
		blockColor = Color.RED
	elif blockStrength == 2:
		blockColor = Color.YELLOW
	elif blockStrength == 3:
		blockColor = Color.GREEN
	else:
		blockColor = Color.BLUE
		
	spriteRef.self_modulate = blockColor


func randomize_block_strength() -> void:
	blockStrength = randi_range(1, 4)


func drop_item() -> void:
	randomItemNumber = randi_range(0, 10)
	
	#if the number is between 6 and 8, spawn another ball.
	#if the number is between 3 and 5, spawn a shield power up
	if randomItemNumber >= 6 and randomItemNumber <= 8:
		get_node("/root/Main2D/BallSpawner").spawn_ball_from_block(self.global_position)
	elif randomItemNumber >= 3 and randomItemNumber <= 5:
		spawn_shield()

#This function creates the shield object 
#	and spawns it in the same global position as the block it spawned from.
func spawn_shield() -> void:
	shieldPowerUp = shieldPowerUpScene.instantiate()
	shieldPowerUp.global_position = self.global_position
	get_node("/root/Main2D").add_child.call_deferred(shieldPowerUp)
	

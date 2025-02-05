extends Node2D

@export var ballScene : PackedScene
#@onready var gameManagerRef := GameManager
@onready var timerRef := $BallSpawnTimer

#This calls the function to spawn the first ball
func _ready() -> void:
	GameManager.zero_balls_on_screen.connect(_on_game_manager_zero_balls_on_screen)
	
	spawn_ball()

#This function creates the ball object 
#	and spawns it in the same global position as the spawner.
#It then adds it to the game manager
func spawn_ball():
	var ball = ballScene.instantiate()
	get_parent().add_child.call_deferred(ball)
	ball.position = self.global_position
	GameManager.add_ball()

#This function creates the ball object 
#	and spawns it in the same global position as the block it spawned from.
#It then adds it to the game manager
func spawn_ball_from_block(block_position : Vector2):
	var ball = ballScene.instantiate()
	get_parent().add_child.call_deferred(ball)
	ball.position = block_position
	GameManager.add_ball()

#This function is called when the signal 
#	inside of the game manager script is emitted.
#It gets emitted when there are no more balls on the screen
#This function starts a cooldown timer
func _on_game_manager_zero_balls_on_screen() -> void:
	timerRef.start()

#This function is called when the timer is done
#This function stops the timer and spawns another ball
func _on_timer_timeout() -> void:
	#print("Stop Timer")
	timerRef.stop()
	spawn_ball()

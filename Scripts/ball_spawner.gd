extends Node2D

@export var ball_scene : PackedScene

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#print(get_parent())
	spawn_ball()


func spawn_ball():
	var ball = ball_scene.instantiate()
	get_parent().add_child.call_deferred(ball)
	ball.position = self.global_position
	$"../GameManager".add_ball()
	
func spawn_ball_from_block(block_position : Vector2):
	var ball = ball_scene.instantiate()
	get_parent().add_child.call_deferred(ball)
	ball.position = block_position
	$"../GameManager".add_ball()
	#print("Spawned Another Ball")


func _on_game_manager_zero_balls_on_screen() -> void:
	#print("Start Timer")
	$BallSpawnTimer.start()


func _on_timer_timeout() -> void:
	#print("Stop Timer")
	$BallSpawnTimer.stop()
	spawn_ball()

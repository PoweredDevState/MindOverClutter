#This node is a sugleton node and is loaded when the game starts
extends Node2D

@export var maxLives := 2
var lives : int
@export var ballsOnScreen := 0

@export var loseScreen : PackedScene
@export var winScreen : PackedScene
@export var pauseScreen : PackedScene

@export var levelScenePaths : Array[String]
#var updatingLevelScenePaths : Array[String]
var currentScenePath : String

signal zero_balls_on_screen
signal lives_changed

func _ready() -> void:
	lives = maxLives


#When the player presses the pause button, spawn the pause screen 
func _process(_delta: float) -> void:
	if Input.is_action_pressed("pause"):
		currentScenePath = get_tree().current_scene.scene_file_path
		
		if levelScenePaths.has(currentScenePath):
			var pauseScreenObj = pauseScreen.instantiate()
			get_parent().add_child.call_deferred(pauseScreenObj)

#This is called in the ball spawner script
func add_ball() -> void:
	ballsOnScreen += 1

#This is called in the ball deleter script
func subtract_ball() -> void:
	ballsOnScreen -= 1
	
	if ballsOnScreen <= 0:
		lose_life()

func lose_life() -> void:
	lives -= 1
	
	if lives < 0:
		print("Lose")
		var loseScreenObj = loseScreen.instantiate()
		get_parent().add_child.call_deferred(loseScreenObj)
	else:
		lives_changed.emit()
		zero_balls_on_screen.emit()


#This is called in the enemy UI script
func win_game() -> void:
	var winScreenObj = winScreen.instantiate()
	get_parent().add_child.call_deferred(winScreenObj)


func reset_game():
	ballsOnScreen = 0
	lives = maxLives

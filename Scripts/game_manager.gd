#This node is a sugleton node and is loaded when the game starts
extends Node2D

@export var maxLives := 2
var currentShields := 0
var lives : int
var ballsOnScreen := 0
@export var levelFinishedTimerTime := 3
@onready var LevelFinishedUIRef := $LevelFinishedUI
@onready var LevelFinishedTimerRef := $LevelFinishedUI/LevelFinishedTimer
var isLevelFinished := false

@export var loseScreen : PackedScene
@export var winScreen : PackedScene
@export var pauseScreen : PackedScene

@export var levelScenePaths : Array[String]
#var updatingLevelScenePaths : Array[String]
var currentScenePath : String
@export var currentSceneIndex : int

signal zero_balls_on_screen
signal lives_changed

func _ready() -> void:
	LevelFinishedTimerRef.wait_time = levelFinishedTimerTime
	LevelFinishedUIRef.visible = false
	lives = maxLives
	


#When the player presses the pause button, spawn the pause screen 
func _process(_delta: float) -> void:
	if Input.is_action_pressed("pause") && isLevelFinished == false:
		currentScenePath = get_tree().current_scene.scene_file_path
		
		if levelScenePaths.has(currentScenePath):
			SoundManager.create_pause_immune_sound(SoundResource.SOUND_TYPE.PAUSED)
			var pauseScreenObj = pauseScreen.instantiate()
			get_parent().add_child.call_deferred(pauseScreenObj)


#This is called in the ball spawner script
func add_ball() -> void:
	ballsOnScreen += 1

#This is called in the ball deleter script
func subtract_ball() -> void:
	ballsOnScreen -= 1

	if ballsOnScreen <= 0:
		SoundManager.create_pause_immune_sound_at_location(global_position, SoundResource.SOUND_TYPE.LIFE_LOST)
		lose_life()

func add_shield() -> void:
	currentShields += 1

func subtract_shield() -> void:
	currentShields -= 1

func lose_life() -> void:
	lives -= 1
	
	if lives == 0:
		MusicManager.change_music(MusicResource.MUSIC_TYPE.PINCH_MUSIC)
	
	if lives < 0:
		#print("Lose")
		var loseScreenObj = loseScreen.instantiate()
		get_parent().add_child.call_deferred(loseScreenObj)
	else:
		lives_changed.emit()
		zero_balls_on_screen.emit()

func check_for_more_levels():
	if currentSceneIndex == levelScenePaths.size() - 1:
		win_game()
	else:
		level_finished()

#This is called in the enemy UI script
func win_game() -> void:
	var winScreenObj = winScreen.instantiate()
	get_parent().add_child.call_deferred(winScreenObj)

func reset_game():
	currentShields = 0
	currentSceneIndex = 0
	ballsOnScreen = 0
	lives = maxLives
	
func reset_balls():
	ballsOnScreen = 0

func start_game():
	currentSceneIndex = 0
	get_tree().change_scene_to_file(levelScenePaths[currentSceneIndex])
	MusicManager.change_music(MusicResource.MUSIC_TYPE.MAIN_MUSIC)

func start_game_from_level_select(levelNum : int) -> void:
	currentSceneIndex = levelNum
	get_tree().change_scene_to_file(levelScenePaths[currentSceneIndex])
	MusicManager.change_music(MusicResource.MUSIC_TYPE.MAIN_MUSIC)

func next_level() -> void:
	reset_balls()
	currentSceneIndex += 1
	get_tree().change_scene_to_file(levelScenePaths[currentSceneIndex])

func level_finished() -> void:
	get_tree().paused = true
	LevelFinishedUIRef.visible = true
	isLevelFinished = true
	LevelFinishedTimerRef.start()

func _on_level_finished_timer_timeout() -> void:
	LevelFinishedTimerRef.stop()
	get_tree().paused = false
	LevelFinishedUIRef.visible = false
	isLevelFinished = false
	next_level()

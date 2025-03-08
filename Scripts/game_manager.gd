#This node is a singleton/autoload node and is loaded when the game starts
extends Node2D

@export var maxLives := 2
var currentShields := 0
var lives : int
var ballsOnScreen := 0
@export var levelFinishedTimerTime := 3
@onready var LevelFinishedUIRef := $LevelFinishedUI
@onready var LevelFinishedTimerRef := $LevelFinishedUI/LevelFinishedTimer
var isLevelFinished := false

#References to Paused Screens
@export var loseScreen : PackedScene
@export var winScreen : PackedScene
@export var pauseScreen : PackedScene

#For level switching
@export var levelScenePaths : Array[String]
var currentScenePath : String
@export var currentSceneIndex : int

#custom signals for other scripts to connect to
signal zero_balls_on_screen
signal lives_changed

#This sets the player lives and sets the LevelFinishedUI attributes
func _ready() -> void:
	LevelFinishedTimerRef.wait_time = levelFinishedTimerTime
	LevelFinishedUIRef.visible = false
	lives = maxLives


#When the player presses the pause button and the level is not finished, 
#spawn the pause screen 
func _process(_delta: float) -> void:
	if Input.is_action_pressed("pause") && isLevelFinished == false:
		currentScenePath = get_tree().current_scene.scene_file_path
		
		if levelScenePaths.has(currentScenePath):
			SoundManager.create_sound(SoundResource.SOUND_TYPE.PAUSED, false)
			var pauseScreenObj = pauseScreen.instantiate()
			get_parent().add_child.call_deferred(pauseScreenObj)


#This is called in the ball spawner script
func add_ball() -> void:
	ballsOnScreen += 1

#This is called in the ball deleter script
#If there are no more, call the lose_life function
func subtract_ball() -> void:
	ballsOnScreen -= 1

	if ballsOnScreen <= 0:
		SoundManager.create_sound_at_location(global_position, SoundResource.SOUND_TYPE.LIFE_LOST, false)
		lose_life()

#This is called in the shield power up script
func add_shield() -> void:
	currentShields += 1

#This is called in the player script
func subtract_shield() -> void:
	currentShields -= 1

#This function gets rid of a life from the player 
#when there are no more balls on the screen.
#When this happens, emit the two signals
#If they are on their last life, change the music
#If they lose their last life, call the lose_game function
func lose_life() -> void:
	lives -= 1
	
	if lives == 0:
		MusicManager.change_music(MusicResource.MUSIC_TYPE.PINCH_MUSIC)
	
	if lives < 0:
		lose_game()
	else:
		lives_changed.emit()
		zero_balls_on_screen.emit()

#This function checks if there are still levels the player did not complete.
#If not, call the win_game function
func check_for_more_levels():
	if currentSceneIndex == levelScenePaths.size() - 1:
		win_game()
	else:
		level_finished()

#This spawns the lose screen
func lose_game() -> void:
	var loseScreenObj = loseScreen.instantiate()
	get_parent().add_child.call_deferred(loseScreenObj)

#This spawns the win screen
func win_game() -> void:
	var winScreenObj = winScreen.instantiate()
	get_parent().add_child.call_deferred(winScreenObj)

#This resets the game state 
#to when the player starts the game in the first level
#This is called in the results_screen and pause_screen scripts
func reset_game():
	currentShields = 0
	currentSceneIndex = 0
	ballsOnScreen = 0
	lives = maxLives

#This resets the balls on screen to 0 when a new level starts
func reset_balls():
	ballsOnScreen = 0

#This transitions to the first level of the game
#This is called in the main_menu script
func start_game():
	currentSceneIndex = 0
	get_tree().change_scene_to_file(levelScenePaths[currentSceneIndex])
	MusicManager.change_music(MusicResource.MUSIC_TYPE.MAIN_MUSIC)

#This transitions to a certain level of the game 
#based on the level the player selected in the level select scene.
#This is called in the level_select script
func start_game_from_level_select(levelNum : int) -> void:
	currentSceneIndex = levelNum
	get_tree().change_scene_to_file(levelScenePaths[currentSceneIndex])
	MusicManager.change_music(MusicResource.MUSIC_TYPE.MAIN_MUSIC)

#This function displays the LevelFinishedUI child node and pauses the game.
#This also starts the LevelFinishedTimer.
func level_finished() -> void:
	get_tree().paused = true
	LevelFinishedUIRef.visible = true
	isLevelFinished = true
	LevelFinishedTimerRef.start()

#This is a function called 
#when the timeout signal in the LevelFinishedTimer is emitted.
#Once the timer is done, unpause the game and call the next_level function
func _on_level_finished_timer_timeout() -> void:
	LevelFinishedTimerRef.stop()
	get_tree().paused = false
	LevelFinishedUIRef.visible = false
	isLevelFinished = false
	next_level()

#This function calls the reset_game function 
#and transitions to the next level in the game.
func next_level() -> void:
	reset_balls()
	currentSceneIndex += 1
	get_tree().change_scene_to_file(levelScenePaths[currentSceneIndex])

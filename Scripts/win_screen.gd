extends Control

@export var menuSceneFilePath : String
var firstLevelFilePath : String

#When the scene is created, pause the game
#NOTE: When the game is paused, 
#	all other nodes and buttons cannot move or be interacted with.
#	In the Node section of this node, 
#	the process section has an dropdown called mode. 
#	When the mode is set to "When Paused," 
#	this means that the player can interact with this node 
#	and the buttons in this node.
func _ready() -> void:
	get_tree().paused = true
	firstLevelFilePath = GameManager.levelScenePaths[0]

#This is called when the restart button is pressed.
#This function unpauses the game and goes to the first level scene
func _on_restart_button_pressed() -> void:
	get_tree().paused = false
	SoundManager.create_sound(SoundResource.SOUND_TYPE.BUTTON_PRESS)
	MusicManager.change_music(MusicResource.MUSIC_TYPE.MAIN_MUSIC)
	GameManager.reset_game()
	get_tree().change_scene_to_file(firstLevelFilePath)
	queue_free()

#This is called when the menu button is pressed.
#This function unpauses the game 
#	and changes the current scene to the menu scene
func _on_menu_button_pressed() -> void:
	get_tree().paused = false
	SoundManager.create_sound(SoundResource.SOUND_TYPE.BUTTON_PRESS)
	MusicManager.change_music(MusicResource.MUSIC_TYPE.MENU_MUSIC)
	GameManager.reset_game()
	get_tree().change_scene_to_file(menuSceneFilePath)
	queue_free()
	

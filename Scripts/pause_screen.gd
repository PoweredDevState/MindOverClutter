extends Control

@export var menuSceneFilePath : String
var currentSceneFilePath : String
var firstLevelFilePath : String

#When the scene is created, get the current scene name for the retry button
#	and pause the game
#NOTE: When the game is paused, 
#	all other nodes and buttons cannot move or be interacted with.
#	In the Node section of this node, 
#	the process section has an dropdown called mode. 
#	When the mode is set to "When Paused," 
#	this means that the player can interact with this node 
#	and the buttons in this node.
func _ready() -> void:
	currentSceneFilePath = get_tree().current_scene.scene_file_path
	get_tree().paused = true
	firstLevelFilePath = GameManager.levelScenePaths[0]

#This is called when the resume button is pressed.
#This function unpauses the game and deletes this node
func _on_resume_button_pressed() -> void:
	get_tree().paused = false
	queue_free()

#This is called when the retry button is pressed.
#This function unpauses the game and reloads the current scene
func _on_retry_button_pressed() -> void:
	get_tree().paused = false
	GameManager.reset_game()
	get_tree().change_scene_to_file(firstLevelFilePath)
	queue_free()

#This is called when the menu button is pressed.
#This function unpauses the game 
#	and changes the current scene to the menu scene
func _on_menu_button_pressed() -> void:
	get_tree().paused = false
	GameManager.reset_game()
	get_tree().change_scene_to_file(menuSceneFilePath)
	queue_free()

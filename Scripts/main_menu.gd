extends Control

@export var startGameFilePath : String
@export var creditsFilePath : String

@export var startGameScene : PackedScene

#This is called when the start button is pressed.
#This function changes the current scene to the first level scene
func _on_start_button_pressed() -> void:
	#get_tree().change_scene_to_file(startGameFilePath)
	GameManager.start_game()
	#get_tree().change_scene_to_packed(startGameScene)

#This is called when the credits button is pressed.
#This function changes the current scene to the credits scene
func _on_credits_button_pressed() -> void:
	get_tree().change_scene_to_file(creditsFilePath)
	#get_tree().change_scene_to_packed(credits)

#This is called when the exit button is pressed.
#This function exits the application
func _on_exit_button_pressed() -> void:
	get_tree().quit()

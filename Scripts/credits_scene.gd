extends Control

@export var menuFilePath : String
@export var menuScene : PackedScene

#This is called when the menu button is pressed.
#This function unpauses the game 
#	and changes the current scene to the menu scene
func _on_menu_button_pressed() -> void:
	get_tree().change_scene_to_file(menuFilePath)
	#get_tree().change_scene_to_packed(menuScene)

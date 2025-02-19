extends Control

@export var menuFilePath : String
@export var menuScene : PackedScene
@export var menuButton : Button


func _ready() -> void:
	'''Future Menu Imporvements
	The bottom if statement is for when 
	I want to have all of the menu scenes, 
	(except for the level select scene and the result and pause screens) 
	have the menu script (This script would be the main_menu script renamed).
	The level select scene will have the same script as before, 
	but it inherits the menu script
	The menu script will have a variable for all of the menu buttons 
	and the ready function will check if it is null or not. 
	If it isn't, connect the pressed signal to their respective functions.
	'''
	
	if menuButton == null:
		print("Not Here")
	else:
		menuButton.pressed.connect(_on_menu_button_pressed)

#This is called when the menu button is pressed.
#This function unpauses the game 
#	and changes the current scene to the menu scene
func _on_menu_button_pressed() -> void:
	SoundManager.create_sound(SoundResource.SOUND_TYPE.BUTTON_PRESS)
	get_tree().change_scene_to_file(menuFilePath)
	#get_tree().change_scene_to_packed(menuScene)

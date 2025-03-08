#NOTE: When updating this project to 4.4, fix the dictionary variables
extends Control

@export var menuFilePath : String
@export var menuScene : PackedScene
@onready var boxContainerRef := $ScrollContainer/BoxContainer
@export var levelButtonScene : PackedScene

var levelButtonsDict : Dictionary = {}

#When this node is instaniated, 
#this creates buttons based on the number of levels 
#stored in the GameManager node.
#It also connects each button's pressed signal to the choose_level function
#and also binds the level number to the choose_level function as a parameter
func _ready() -> void:
	for num in GameManager.levelScenePaths.size():
		var buttonObj = levelButtonScene.instantiate()
		boxContainerRef.add_child.call_deferred(buttonObj)
		buttonObj.text = "Level " + str(num + 1)
		
		levelButtonsDict[num] = buttonObj
		levelButtonsDict[num].pressed.connect(choose_level.bind(num))

#This is called when the menu button is pressed.
#This function changes the current scene to the menu scene
func _on_menu_button_pressed() -> void:
	SoundManager.create_sound(SoundResource.SOUND_TYPE.BUTTON_PRESS, true)
	get_tree().change_scene_to_file(menuFilePath)

#This is a function that is called when that specific level button is pressed.
#This function calls a function in the GameManager script 
#to transition to a level based on the level number argument
func choose_level(levelNumber : int) -> void:
	SoundManager.create_sound(SoundResource.SOUND_TYPE.BUTTON_PRESS, true)
	GameManager.start_game_from_level_select(levelNumber)

extends Control

#@export var startGameFilePath : String
@export var creditsFilePath : String
@export var instructionsFilePath : String
@export var levelSelectFilePath : String

'''Scene Switcher Idea
This is for when I want to make a scene manager node
The idea is to make each scene that I want to switch into a resource.
The class will contain a list of enums for the scene names.
Each resource will have an exported enum var for the scene name, 
an exported packedScene for the scene itself, 
and a non-exported variable for the filepath.
In the ready function of the SceneSwitcher, 
it will initialize a dictionary of scenes to load from an array 
of all of the sceneResources. 
Then, it will initialize the scenePath variable in each resource 
using the resource_path of the PackedScene


@export var startGameScene : PackedScene
func _ready() -> void:
	print(startGameScene.resource_path)
'''


#This is called when the start button is pressed.
#This function changes the current scene to the first level scene
func _on_start_button_pressed() -> void:
	#get_tree().change_scene_to_file(startGameFilePath)
	SoundManager.create_sound(SoundResource.SOUND_TYPE.BUTTON_PRESS, true)
	
	if Input.is_action_pressed("Secret Hold"):
		get_tree().change_scene_to_file(levelSelectFilePath)
		
	else:
		GameManager.start_game()
	#get_tree().change_scene_to_packed(startGameScene)

#This is called when the credits button is pressed.
#This function changes the current scene to the credits scene
func _on_credits_button_pressed() -> void:
	SoundManager.create_sound(SoundResource.SOUND_TYPE.BUTTON_PRESS, true)
	
	get_tree().change_scene_to_file(creditsFilePath)
	#get_tree().change_scene_to_packed(credits)

#This is called when the exit button is pressed.
#This function exits the application
func _on_exit_button_pressed() -> void:
	get_tree().quit()

#This is called when the instructions button is pressed.
#This function changes the current scene to the instructions scene
func _on_instructions_button_pressed() -> void:
	SoundManager.create_sound(SoundResource.SOUND_TYPE.BUTTON_PRESS, true)
	
	get_tree().change_scene_to_file(instructionsFilePath)

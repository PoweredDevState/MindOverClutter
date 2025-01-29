extends Control

@export var menuSceneFilePath : String
@export var firstLevelFilePath : String

func _ready() -> void:
	get_tree().paused = true

func _on_restart_button_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file(firstLevelFilePath)

func _on_menu_button_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file(menuSceneFilePath)

extends Control

@export var menuSceneFilePath : String
var currentSceneFilePath : String

func _ready() -> void:
	get_tree().paused = true

func set_current_scene_name(scenePath : String) -> void:
	currentSceneFilePath = scenePath

func _on_retry_button_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file(currentSceneFilePath)


func _on_menu_button_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file(menuSceneFilePath)

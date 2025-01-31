extends Control

@export var menuSceneFilePath : String
var currentSceneFilePath : String


func _ready() -> void:
	currentSceneFilePath = get_tree().current_scene.scene_file_path
	get_tree().paused = true


func _on_resume_button_pressed() -> void:
	get_tree().paused = false
	queue_free()


func _on_retry_button_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file(currentSceneFilePath)


func _on_menu_button_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file(menuSceneFilePath)

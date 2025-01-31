extends Control

@export var startGameFilePath : String
@export var creditsFilePath : String

@export var startGameScene : PackedScene

func _on_start_button_pressed() -> void:
	#get_tree().change_scene_to_file(startGameFilePath)
	get_tree().change_scene_to_packed(startGameScene)


func _on_credits_button_pressed() -> void:
	get_tree().change_scene_to_file(creditsFilePath)
	#get_tree().change_scene_to_packed(credits)


func _on_exit_button_pressed() -> void:
	get_tree().quit()

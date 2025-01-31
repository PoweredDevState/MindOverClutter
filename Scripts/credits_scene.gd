extends Control

@export var menuFilePath : String
@export var menuScene : PackedScene



func _on_menu_button_pressed() -> void:
	get_tree().change_scene_to_file(menuFilePath)
	#get_tree().change_scene_to_packed(menuScene)

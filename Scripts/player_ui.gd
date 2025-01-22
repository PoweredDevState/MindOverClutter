extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$LifeNumber.text = str($"../GameManager".lives)


func _on_game_manager_lives_changed() -> void:
	$LifeNumber.text = str($"../GameManager".lives)

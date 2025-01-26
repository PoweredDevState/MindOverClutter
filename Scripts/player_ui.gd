extends Control

@onready var lifeNumRef := $LifeNumber
@onready var gameManagerRef := $"../GameManager"

@onready var playerRef := $"../Player"
@onready var stunUIRef := $StunnedUI

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	lifeNumRef.text = str(gameManagerRef.lives)
	stunUIRef.get_node("ProgressBar").max_value = \
		+ playerRef.get_node("StunTimer").wait_time
	stunUIRef.get_node("ProgressBar").value = \
		+ playerRef.get_node("StunTimer").wait_time
	stunUIRef.visible = false

func _process(delta: float) -> void:
	if stunUIRef.visible == true:
		stunUIRef.get_node("ProgressBar").value = \
			+ playerRef.get_node("StunTimer").time_left

func _on_game_manager_lives_changed() -> void:
	lifeNumRef.text = str(gameManagerRef.lives)

func _on_player_player_stunned() -> void:
	stunUIRef.visible = true

func _on_player_player_finished_stun() -> void:
	stunUIRef.visible = false

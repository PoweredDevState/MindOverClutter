extends Control


#@onready var gameManagerRef := GameManager


#This function is called when the signal inside of the enemy script is emitted.
#It gets emitted when the current health is changed in the enemy script.
#This function changes the value of the progress bar 
#	to the current health of the enemy
func _on_enemy_health_changed(health_value: float) -> void:
	$ProgressBar.value = health_value
	
	if $ProgressBar.value <= 0:
		GameManager.win_game()

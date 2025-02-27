extends Control

@onready var healthBarRef := $HealthBar

#This function is called when the signal inside of the enemy script is emitted.
#It gets emitted when the current health is changed in the enemy script.
#This function changes the value of the progress bar 
#	to the current health of the enemy
func _on_enemy_health_changed(health_value: float) -> void:
	healthBarRef.value = health_value
	
	if healthBarRef.value <= 0:
		GameManager.check_for_more_levels()

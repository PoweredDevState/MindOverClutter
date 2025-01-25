extends Control


func _on_enemy_health_changed(health_value) -> void:
	$ProgressBar.value = health_value

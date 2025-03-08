extends Control

@onready var timerRef := $LevelFinishedTimer

#When the level is finished, set the timer text to the time left on the timer
func _process(_delta: float) -> void:
	if GameManager.isLevelFinished == true:
		var time_left = int(timerRef.time_left)
		get_node("TimerText").text = str(time_left)

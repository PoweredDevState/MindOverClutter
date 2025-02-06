extends Control

@onready var timerRef := $LevelFinishedTimer

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if GameManager.isLevelFinished == true:
		var time_left = int(timerRef.time_left)
		get_node("TimerText").text = str(time_left)

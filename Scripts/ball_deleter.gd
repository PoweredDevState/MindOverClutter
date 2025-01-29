extends Area2D


#This function is called when the ball enters the area.
#This destroys the ball and subtracts it from the game manager
func _on_body_entered(body: Node2D) -> void:
	body.queue_free()
	$"../GameManager".subtract_ball()

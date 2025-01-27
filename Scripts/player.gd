extends CharacterBody2D

@export var speed := 300.0

#for the stun mechanic
var isStunned := false
var normalColor : Color
@export var stunColor := Color.DARK_RED
@export var stunTime := 3
@onready var spriteRef := $PlayerSprite
@onready var stunTimerRef := $StunTimer

#signals for the playerUI script
signal player_stunned
signal player_finished_stun

#for the shield powerup
var shielded := false

func _ready() -> void:
	normalColor = spriteRef.self_modulate
	stunTimerRef.wait_time = stunTime

func _physics_process(delta: float) -> void:
	# Get the input direction and handle the movement/deceleration.
	
	#NOTE: get_axis treats move_up as negative and move_down as positive
	# move_up makes direction = -1, move_down makes direction = 1
	var direction := Input.get_axis("move_up", "move_down")
	
	velocity.y = direction * speed
	
	'''
	if direction != 0:
		print(direction)
		print(velocity)
	'''
	
	#move_and_slide()
	if isStunned == false:
		move_and_collide(velocity * delta)

#This function changes the stun state based on the parameter.
#If the player has the shield power-up, the player is not stunned,
#but the shield power-up is disabled
func set_stun(state : bool) -> void:
	if shielded == false:
		isStunned = state
		_set_sprite_color()
	else:
		shielded = false
	
	if isStunned == true:
		_start_timer()
		
	
func _set_sprite_color() -> void:
	if isStunned == true:
		spriteRef.self_modulate = stunColor
	else:
		spriteRef.self_modulate = normalColor

func _start_timer() -> void:
	stunTimerRef.start()
	player_stunned.emit()

func _on_stun_timer_timeout() -> void:
	stunTimerRef.stop()
	set_stun(false)
	player_finished_stun.emit()

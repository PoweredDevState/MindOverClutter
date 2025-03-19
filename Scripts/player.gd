extends CharacterBody2D

@export var speed := 300.0

#for the stun mechanic
var isStunned := false
var normalColor : Color
@export var stunColor := Color.DARK_RED
@export var stunTime := 3
@onready var spriteRef := $PlayerSprite
@onready var stunTimerRef := $StunTimer
@onready var stunSoundPlayerRef := $StunnedSoundPlayer

#signals for the playerUI script
signal player_stunned
signal player_finished_stun

#for the shield powerup
var isShielded := false
var numOfShields := 0
signal shield_state_changed

#When the player script in initialized,
#set the initial values.
#If the GameManager script has shields,
#set those shield values.
func _ready() -> void:
	normalColor = spriteRef.self_modulate
	stunTimerRef.wait_time = stunTime
	
	if GameManager.currentShields != 0:
		numOfShields = GameManager.currentShields
		isShielded = true
		
		for num in numOfShields:
			set_shield(true)

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
	
	if isStunned == false:
		move_and_collide(velocity * delta)

#This is called inside of the shield power up script 
#	and in the set stun function
#This function takes in a boolean 
#	indicating that the player either got a shield or took damage.
#If the boolean is true, increase the number of shields by 1.
#Else, call the GameManager script to decrease the number of shields by 1.
#This also emits a signal to the playerUI script 
#	to change how many shields are shown to the player
func set_shield(state : bool) -> void:
	isShielded = state
	if isShielded == true:
		numOfShields += 1
		
	else:
		SoundManager.create_sound_at_location(global_position,SoundResource.SOUND_TYPE.SHIELD_BROKEN, true)
		numOfShields -= 1
		GameManager.subtract_shield()
	shield_state_changed.emit(isShielded)

#This function changes the stun state based on the parameter.
#If the player has the shield power-up, the player is not stunned,
#but a shield is taken away from the player
func set_stun(state : bool) -> void:
	if numOfShields == 0:
		isStunned = state
		_set_sprite_color()
		
	#This condition is to prevent a bug 
	#	where just when the player is stunned, 
	#	if a shield is moving towards the player, 
	#	the player gains a shield. And when the stun state is done, 
	#	the color does not change immediately.
	elif numOfShields != 0 && isStunned == true:
		isStunned = state
		_set_sprite_color()
	else:
		set_shield(false)
	
	if isStunned == true:
		stunSoundPlayerRef.play()
		_start_stun_timer()


func _set_sprite_color() -> void:
	if isStunned == true:
		spriteRef.self_modulate = stunColor
	else:
		spriteRef.self_modulate = normalColor

#This function starts the stun timer 
#and emits the player_stunned signal for the playerUI script
func _start_stun_timer() -> void:
	stunTimerRef.start()
	player_stunned.emit()

#This function is called when the timeout signal is emitted from the timer.
#This stops the timer and calls the set_stun function with the false argument.
#It also emits the player_finished_stun signal for the playerUI script
func _on_stun_timer_timeout() -> void:
	stunTimerRef.stop()
	stunSoundPlayerRef.stop()
	set_stun(false)
	player_finished_stun.emit()

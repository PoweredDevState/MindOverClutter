extends Control

#References to nodes in scene
@onready var lifeNumRef := $LifeNumber
#@onready var gameManagerRef := GameManager
@onready var playerRef := $"../Player"
@onready var stunUIRef := $StunnedUI
@onready var ShieldIconContainerRef := $ShieldIconContainer

#Reference to shield icon scene
@export var shieldIconScene : PackedScene
var shieldIcon : TextureRect

#Sets up the UI at the start of the game
func _ready() -> void:
	playerRef.player_stunned.connect(_on_player_stunned)
	playerRef.player_finished_stun.connect(_on_player_finished_stun)
	playerRef.shield_state_changed.connect(_on_player_shield_state_changed)
	GameManager.lives_changed.connect(_on_game_manager_lives_changed)
	
	#Sets up the lives UI using the GameManager node
	lifeNumRef.text = str(GameManager.lives)
	
	#Sets up the stun progress bar by setting the max value 
	#	to the wait time
	stunUIRef.get_node("ProgressBar").max_value = \
		+ playerRef.stunTime
	stunUIRef.get_node("ProgressBar").value = \
		+ playerRef.stunTime
		
	#Makes the stun bar invisible
	stunUIRef.visible = false
	

#if the stunbar is visible, set the current value 
#	to the remaining time on the stun timer
func _process(_delta: float) -> void:
	if stunUIRef.visible == true:
		stunUIRef.get_node("ProgressBar").value = \
			+ playerRef.get_node("StunTimer").time_left

#This function is called when the signal 
#	inside of the game manager script is emitted.
#It gets emitted when the lives is changed in the game manager script.
#This function changes the text of lives number
func _on_game_manager_lives_changed() -> void:
	lifeNumRef.text = str(GameManager.lives)


#This function is called when the signal 
#	inside of the player script is emitted.
#It gets emitted when the shield state is changed.
#This function changes how many icons the shield icon container has.
func _on_player_shield_state_changed(state : bool) -> void:
	if state == true:
		add_shield_icon()
	else:
		ShieldIconContainerRef.get_child(0).queue_free()

func add_shield_icon() -> void:
	shieldIcon = shieldIconScene.instantiate()
	ShieldIconContainerRef.add_child.call_deferred(shieldIcon)

#This function is called when the signal 
#	inside of the player script is emitted.
#It gets emitted when the player gets stunned.
#This function shows the stun UI
func _on_player_stunned() -> void:
	stunUIRef.visible = true


#This function is called when the signal 
#	inside of the enemy script is emitted.
#It gets emitted when the player is not stunned anymore.
#This function hides the stun UI
func _on_player_finished_stun() -> void:
	stunUIRef.visible = false

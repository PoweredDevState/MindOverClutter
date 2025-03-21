extends CharacterBody2D

@export var enemyResource : EnemyResource

#For Health Management
var currentHealth : int
var maxHealth := 3
var healthPercentage : float
signal health_changed


'''For Attacking'''
enum AttackStates {CHARGE, INDICATING, ATTACK, RECHARGE}
var currentAttackState: AttackStates

#this array ensures that each condition in the match statement runs only once
var attackChecks := [true, true, true, true]

var attackTransformX : float
var minAttackTransformY : float
var maxAttackTransformY : float
var chargeTime : int
var readyToAttack := true
@export var attackIndiactorScene : PackedScene
var attackIndiactor : Object
#@export var attackScene : PackedScene
var attackObject : Object
var attackPosition : Vector2
@onready var chargeTimerRef := $ChargeTimer
@onready var indicatorTimerRef := $IndicatorTimer
@onready var rechargeTimerRef := $RechargeTimer

#this sets up the health and the area where the enemy can attack
func _ready() -> void:
	#For when I will use resources for specific enemy data
	$EnemySprite.texture = enemyResource.sprite
	$EnemySprite.scale = Vector2(enemyResource.spriteScale, enemyResource.spriteScale)
	maxHealth = enemyResource.maxHealth
	currentHealth = maxHealth
	change_health_percentage()
	
	attackTransformX = $"../StartAttackMark".global_position.x
	minAttackTransformY = $"../StartAttackMark".global_position.y
	maxAttackTransformY = $"../EndAttackMark".global_position.y
	
	#starts the enemy off in the charge attack state
	currentAttackState = AttackStates.CHARGE

#This function manages the attack states of the enemy.
#Once the enemy enters that state, it will perform the statements once
#Each value inside of the attackChecks array become false 
#	as the enemy goes through all of the attack states.
#This is to ensure that each condition run only once
func _process(_delta: float) -> void:
	match currentAttackState:
		AttackStates.CHARGE:
			if attackChecks[0] == true:
				attackChecks[0] = false
				#print("CHARGE")
				set_charge_timer()
				chargeTimerRef.start()
				
		AttackStates.INDICATING:
			if attackChecks[1] == true:
				attackChecks[1] = false
				#print("INDICATING")
				spawn_indicator()
				indicatorTimerRef.start()
				
		AttackStates.ATTACK:
			if attackChecks[2] == true:
				attackChecks[2] = false
				#print("ATTACK")
				spawn_attack()
				
		AttackStates.RECHARGE:
			if attackChecks[3] == true:
				attackChecks[3] = false
				#print("RECHARGE")
				rechargeTimerRef.start()
			

#This function is called in the ball script 
#when it collides with the enemy. 
#This reduces the health variable by 1. 
#When their health is reduced to 0, destroy the enemy.
func reduce_health() -> void:
	currentHealth -= 1
	change_health_percentage()
	
	#Depending on the health, it plays a different sound
	if currentHealth == 0:
		SoundManager.create_sound_at_location(global_position, SoundResource.SOUND_TYPE.ENEMY_DEATH, false)
		queue_free()
	else:
		SoundManager.create_sound_at_location(global_position, SoundResource.SOUND_TYPE.ENEMY_HIT, false)

#this function creates a health percentage out of 100 for the enemy UI.
#This also emits a signal to the enemy UI to change its progress bar
#	based on the percentage
func change_health_percentage() -> void:
	healthPercentage = (float(currentHealth) / maxHealth) * 100
	health_changed.emit(healthPercentage)

#this function sets the charge time to a random number between 4 and 10
func set_charge_timer() -> void:
	chargeTime = randi_range(4, 10)
	chargeTimerRef.wait_time = chargeTime

#this function calls the randomize_attack_position() function
#	and spawns an indicator to that location
func spawn_indicator() -> void:
	randomize_attack_position()
	attackIndiactor = attackIndiactorScene.instantiate()
	attackIndiactor.global_position = attackPosition
	get_parent().add_child.call_deferred(attackIndiactor)

#this function chooses a random attack position 
#	between the area where the player moves 
func randomize_attack_position() -> void:
	var randomAttackTransformY = \
		+ randf_range(minAttackTransformY, maxAttackTransformY)
	attackPosition = Vector2(attackTransformX, randomAttackTransformY)

#This receiver function is called when the charge timer is done
#This function stops the timer 
#	and changes the current attack state to indicating
func _on_charge_timer_timeout() -> void:
	chargeTimerRef.stop()
	currentAttackState = AttackStates.INDICATING

#This receiver function is called when the indicator timer is done
#This function stops the timer 
#	and changes the current attack state to attack
func _on_indicator_timer_timeout() -> void:
	indicatorTimerRef.stop()
	currentAttackState = AttackStates.ATTACK

#This function destroys the attack indicator 
#	and spawns the attack to the previous location of the indicator 
#This also changes the current attack state to recharge
func spawn_attack() -> void:
	attackIndiactor.queue_free()
	
	#Spawn Attack
	attackObject = enemyResource.attackScene.instantiate()
	attackObject.global_position = attackPosition
	get_parent().add_child.call_deferred(attackObject)
	
	currentAttackState = AttackStates.RECHARGE

#This receiver function is called when the recharge timer is done
#This function stops the timer 
#	and calls the reset_attack_states() function
func _on_recharge_timer_timeout() -> void:
	rechargeTimerRef.stop()
	reset_attack_states()

#This function sets all of the values in the attackChecks array to true
#	and changes the current attack state to charge, resetting the enemy
func reset_attack_states() -> void:
	for currentCheck in attackChecks.size():
		attackChecks[currentCheck] = true
	
	currentAttackState = AttackStates.CHARGE

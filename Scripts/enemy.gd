extends CharacterBody2D

#For Health Management
var currentHealth : int
@export var maxHealth := 3
var healthPercentage : float
signal health_changed

#For Attacking
enum AttackStates {CHARGE, INDICATING, ATTACK, RECHARGE}
var currentAttackState: AttackStates

#this array insures that each condition in the match statement runs only once
var attackChecks := [true, true, true, true]

var attackTransformX : float
var minAttackTransformY : float
var maxAttackTransformY : float
var chargeTime : int
var readyToAttack := true
@export var attackIndiactorScene : PackedScene
var attackIndiactor : Object
@export var attackScene : PackedScene
var attackObject : Object
var attackPosition : Vector2

@onready var chargeTimerRef := $ChargeTimer
@onready var indicatorTimerRef := $IndicatorTimer
@onready var rechargeTimerRef := $RechargeTimer

func _ready() -> void:
	currentHealth = maxHealth
	change_health_percentage()
	
	attackTransformX = $"../StartAttackMark".global_position.x
	minAttackTransformY = $"../StartAttackMark".global_position.y
	maxAttackTransformY = $"../EndAttackMark".global_position.y
	
	currentAttackState = AttackStates.CHARGE


func _process(delta: float) -> void:
	match currentAttackState:
		AttackStates.CHARGE:
			if attackChecks[0] == true:
				attackChecks[0] = false
				print("CHARGE")
				set_charge_timer()
				chargeTimerRef.start()
				
		AttackStates.INDICATING:
			if attackChecks[1] == true:
				attackChecks[1] = false
				print("INDICATING")
				spawn_indicator()
				indicatorTimerRef.start()
				
		AttackStates.ATTACK:
			if attackChecks[2] == true:
				attackChecks[2] = false
				print("ATTACK")
				spawn_attack()
				
		AttackStates.RECHARGE:
			if attackChecks[3] == true:
				attackChecks[3] = false
				print("RECHARGE")
				rechargeTimerRef.start()
			

func reduce_health() -> void:
	currentHealth -= 1
	change_health_percentage()
	
	if currentHealth == 0:
		queue_free()

func change_health_percentage() -> void:
	healthPercentage = (float(currentHealth) / maxHealth) * 100
	health_changed.emit(healthPercentage)


func set_charge_timer() -> void:
	chargeTime = randi_range(4, 10)
	chargeTimerRef.wait_time = chargeTime


func spawn_indicator() -> void:
	randomize_attack_position()
	attackIndiactor = attackIndiactorScene.instantiate()
	attackIndiactor.global_position = attackPosition
	get_parent().add_child.call_deferred(attackIndiactor)


func randomize_attack_position() -> void:
	var randomAttackTransformY = randf_range(minAttackTransformY, maxAttackTransformY)
	attackPosition = Vector2(attackTransformX, randomAttackTransformY)


func _on_charge_timer_timeout() -> void:
	chargeTimerRef.stop()
	currentAttackState = AttackStates.INDICATING

func _on_indicator_timer_timeout() -> void:
	indicatorTimerRef.stop()
	currentAttackState = AttackStates.ATTACK

func spawn_attack() -> void:
	attackIndiactor.queue_free()
	
	#Spawn Attack
	attackObject = attackScene.instantiate()
	attackObject.global_position = attackPosition
	get_parent().add_child.call_deferred(attackObject)
	
	currentAttackState = AttackStates.RECHARGE

func _on_recharge_timer_timeout() -> void:
	rechargeTimerRef.stop()
	reset_attack_states()
	
func reset_attack_states() -> void:
	for currentCheck in attackChecks.size():
		attackChecks[currentCheck] = true
	
	currentAttackState = AttackStates.CHARGE

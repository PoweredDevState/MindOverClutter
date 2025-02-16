extends Resource
class_name SoundResource

enum SOUND_TYPE {
	ATTACK_HIT,
	ATTACK_INDICATOR,
	BALL_HIT,
	BLOCK_DESTROYED,
	BUTTON_PRESS,
	ENEMY_HIT,
	LIFE_LOST,
	PAUSED,
	SHIELD_BROKEN,
	SHIELD_UP,
	STUNNED
}

@export var soundType : SOUND_TYPE
@export var sound : AudioStreamWAV
@export_range(0, 100) var volume : float = 100

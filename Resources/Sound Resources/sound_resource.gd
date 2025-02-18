extends Resource
class_name SoundResource

enum SOUND_TYPE {
	ATTACK_HIT,
	ATTACK_INDICATOR,
	ATTACK_EXPLOSION,
	BALL_HIT,
	BLOCK_DESTROYED,
	BUTTON_PRESS,
	ENEMY_HIT,
	LIFE_LOST,
	PAUSED,
	SHIELD_BROKEN,
	SHIELD_UP,
	STUNNED,
	ENEMY_DEATH
}

@export var soundType : SOUND_TYPE
@export var sound : AudioStreamWAV
@export_range(-50, 50) var volume : float = -10
@export_range(0, 10) var limit : int = 5
var audioCount : int = 0

func change_audio_count(amount: int) -> void:
	audioCount = max(0, audioCount + amount)

func has_open_limit() -> bool:
	return audioCount < limit

func on_audio_finished() -> void:
	change_audio_count(-1)

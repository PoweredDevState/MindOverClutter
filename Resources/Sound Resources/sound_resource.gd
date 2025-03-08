extends Resource
class_name SoundResource

#This resource script is for each different sound type in the game
#This resource also contains a enum type of each sound
#to easily verify the sound type for the sound manager

#SoundResource script based on Aarimous' AudioManager project
#Video Link: https://www.youtube.com/watch?v=Egf2jgET3nQ&list=PLPa54potuqXIjxpqrhlXBvJYa7Vu2p_x_&index=5 
#GitHub Link: https://github.com/Aarimous/AudioManager
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

#This function adds the amount of instances of the audio to itself
func change_audio_count(amount: int) -> void:
	audioCount = max(0, audioCount + amount)

#This function checks if the audio instances have reached the limit
func has_open_limit() -> bool:
	return audioCount < limit

#This function reduces the audio instances by 1 
#when the audio is finished
func on_audio_finished() -> void:
	change_audio_count(-1)

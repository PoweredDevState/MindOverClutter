extends Node2D

@export var soundEffects: Array[SoundResource]

var soundDict : Dictionary = {}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for soundEffect : SoundResource in soundEffects:
		soundDict[soundEffect.soundType] = soundEffect


func create_sound_at_location(location: Vector2, type: SoundResource.SOUND_TYPE) -> void:
	pass
	
func create_sound(type: SoundResource.SOUND_TYPE) -> void:
	pass

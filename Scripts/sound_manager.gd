extends Node2D

@export var soundEffects: Array[SoundResource]

var soundDict : Dictionary = {}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for soundEffect : SoundResource in soundEffects:
		soundDict[soundEffect.soundType] = soundEffect


func create_sound_at_location(location: Vector2, type: SoundResource.SOUND_TYPE) -> void:
	if soundDict.has(type):
		var soundEffect: SoundResource = soundDict[type]
		if soundEffect.has_open_limit():
			soundEffect.change_audio_count(1)
			var new2DAudio: AudioStreamPlayer2D = AudioStreamPlayer2D.new()
			add_child(new2DAudio)
			new2DAudio.position = location
			new2DAudio.stream = soundEffect.sound
			new2DAudio.volume_db = soundEffect.volume
			new2DAudio.finished.connect(soundEffect.on_audio_finished)
			new2DAudio.finished.connect(new2DAudio.queue_free)
			new2DAudio.play()
	else:
		push_error("Cannot find type ", type)
	
	
func create_sound(type: SoundResource.SOUND_TYPE) -> void:
	if soundDict.has(type):
		var soundEffect: SoundResource = soundDict[type]
		if soundEffect.has_open_limit():
			soundEffect.change_audio_count(1)
			var new2DAudio: AudioStreamPlayer2D = AudioStreamPlayer2D.new()
			add_child(new2DAudio)
			new2DAudio.stream = soundEffect.sound
			new2DAudio.volume_db = soundEffect.volume
			new2DAudio.finished.connect(soundEffect.on_audio_finished)
			new2DAudio.finished.connect(new2DAudio.queue_free)
			new2DAudio.play()
			new2DAudio.process_mode = Node.PROCESS_MODE_ALWAYS
	else:
		push_error("Cannot find type ", type)


func create_pause_immune_sound(type: SoundResource.SOUND_TYPE) -> void:
	if soundDict.has(type):
		var soundEffect: SoundResource = soundDict[type]
		if soundEffect.has_open_limit():
			soundEffect.change_audio_count(1)
			var new2DAudio: AudioStreamPlayer2D = AudioStreamPlayer2D.new()
			new2DAudio.process_mode = Node.PROCESS_MODE_ALWAYS
			add_child(new2DAudio)
			new2DAudio.stream = soundEffect.sound
			new2DAudio.volume_db = soundEffect.volume
			new2DAudio.finished.connect(soundEffect.on_audio_finished)
			new2DAudio.finished.connect(new2DAudio.queue_free)
			new2DAudio.play()
		
	else:
		push_error("Cannot find type ", type)


func create_pause_immune_sound_at_location(location: Vector2, type: SoundResource.SOUND_TYPE) -> void:
	if soundDict.has(type):
		var soundEffect: SoundResource = soundDict[type]
		if soundEffect.has_open_limit():
			soundEffect.change_audio_count(1)
			var new2DAudio: AudioStreamPlayer2D = AudioStreamPlayer2D.new()
			new2DAudio.process_mode = Node.PROCESS_MODE_ALWAYS
			add_child(new2DAudio)
			new2DAudio.position = location
			new2DAudio.stream = soundEffect.sound
			new2DAudio.volume_db = soundEffect.volume
			new2DAudio.finished.connect(soundEffect.on_audio_finished)
			new2DAudio.finished.connect(new2DAudio.queue_free)
			new2DAudio.play()
		
	else:
		push_error("Cannot find type ", type)

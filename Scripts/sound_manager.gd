#This node is a singleton/autoload node and is loaded when the game starts
extends Node2D

@export var soundEffects: Array[SoundResource]

var soundDict : Dictionary = {}

#When this node is instaniated, 
#this initializes the sound dictionary based on the soundEffects array.
func _ready() -> void:
	for soundEffect : SoundResource in soundEffects:
		soundDict[soundEffect.soundType] = soundEffect

#This function creates a sound effect 
#based on sound type and location parameter.
#This can be called by any script that wants to play a particular sound 
#at a location based on its action.
func create_sound_at_location(location: Vector2, type: SoundResource.SOUND_TYPE, pausable : bool) -> void:
	
	#If the dictionary has the specific sound type as a key, 
	#create a soundEffect variable from that value 
	#in the dictionary with that key.
	if soundDict.has(type):
		var soundEffect: SoundResource = soundDict[type]
		
		#If the soundEffect has not reached the limit of sounds it can produce,
		#add a count to the sound effect and create a new audioStreamPlayer2D
		#and add it as a child. Set the location of the sound 
		#and each of the attributes of the soundEffect variable 
		#to the audioStreamPlayer variable and play the sound.
		#Connect the finished signal of the audioStream variable 
		#to both the on_audio_finished function of the soundEffect variable 
		#and queue_free functions of the audioStream variable 
		#to delete the audio when it is done
		if soundEffect.has_open_limit():
			soundEffect.change_audio_count(1)
			var new2DAudio: AudioStreamPlayer2D = AudioStreamPlayer2D.new()
			
			if pausable == false:
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


#This function creates a sound effect 
#based on sound type parameter.
#This can be called by any script that wants to play a particular sound 
#based on its action.
func create_sound(type: SoundResource.SOUND_TYPE, pausable : bool) -> void:

	#If the dictionary has the specific sound type as a key, 
	#create a soundEffect variable from that value 
	#in the dictionary with that key.
	if soundDict.has(type):
		var soundEffect: SoundResource = soundDict[type]
		
		#If the soundEffect has not reached the limit of sounds it can produce,
		#add a count to the sound effect and create a new audioStreamPlayer2D
		#and add it as a child. Set each of the attributes 
		#of the soundEffect variable 
		#to the audioStreamPlayer variable and play the sound.
		#Connect the finished signal of the audioStream variable 
		#to both the on_audio_finished function of the soundEffect variable 
		#and queue_free functions of the audioStream variable 
		#to delete the audio when it is done
		if soundEffect.has_open_limit():
			soundEffect.change_audio_count(1)
			var new2DAudio: AudioStreamPlayer2D = AudioStreamPlayer2D.new()
			
			if pausable == false:
				new2DAudio.process_mode = Node.PROCESS_MODE_ALWAYS
			
			add_child(new2DAudio)
			new2DAudio.stream = soundEffect.sound
			new2DAudio.volume_db = soundEffect.volume
			new2DAudio.finished.connect(soundEffect.on_audio_finished)
			new2DAudio.finished.connect(new2DAudio.queue_free)
			new2DAudio.play()
			#new2DAudio.process_mode = Node.PROCESS_MODE_ALWAYS
	else:
		push_error("Cannot find type ", type)

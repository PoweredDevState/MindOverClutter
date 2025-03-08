#This node is a singleton/autoload node and is loaded when the game starts
extends Node2D

@export var musicResources: Array[MusicResource]
@onready var musicPlayerRef := $MusicPlayer

var musicDict : Dictionary = {}

#When this node is instaniated, 
#this initializes the music dictionary based on the musicResources array.
#It then sets up the music player to play the menu music
func _ready() -> void:
	for music : MusicResource in musicResources:
		musicDict[music.musicType] = music
	
	#if the dictionary has the menu music type as a key, 
	#create a musicResource variable from that value 
	#in the dictionary with that key and set the musicPlayerRef 
	#equal to the audioStream and volume and play the music
	if musicDict.has(MusicResource.MUSIC_TYPE.MENU_MUSIC):
		var type: MusicResource.MUSIC_TYPE = MusicResource.MUSIC_TYPE.MENU_MUSIC
		
		var music: MusicResource = musicDict[type]
		
		musicPlayerRef.stream = music.music
		musicPlayerRef.volume_db = music.volume
		musicPlayerRef.play()
	else:
		push_error("Cannot find menu music")

#This function changes the music based on music type parameter.
#This is called when the scene changes 
#to either the menu or main level scenes.
#It is also called in the GameManager script 
#when the player is on their last life.
func change_music(type: MusicResource.MUSIC_TYPE):
	
	#if the dictionary has the specific music type as a key, 
	#create a musicResource variable from that value 
	#in the dictionary with that key and set the musicPlayerRef 
	#equal to the audioStream and volume and play the music
	if musicDict.has(type):
		var music: MusicResource = musicDict[type]
		
		musicPlayerRef.stream = music.music
		musicPlayerRef.volume_db = music.volume
		musicPlayerRef.play()
		
	else:
		push_error("Cannot find type ", type)

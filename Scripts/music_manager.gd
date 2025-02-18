extends Node2D

@export var musicResources: Array[MusicResource]
@onready var musicPlayerRef := $MusicPlayer

var musicDict : Dictionary = {}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for music : MusicResource in musicResources:
		musicDict[music.musicType] = music
	
	if musicDict.has(MusicResource.MUSIC_TYPE.MENU_MUSIC):
		var type: MusicResource.MUSIC_TYPE = MusicResource.MUSIC_TYPE.MENU_MUSIC
		
		var music: MusicResource = musicDict[type]
		
		musicPlayerRef.stream = music.music
		musicPlayerRef.volume_db = music.volume
		musicPlayerRef.play()
	else:
		push_error("Cannot find menu music")
		
func change_music(type: MusicResource.MUSIC_TYPE):
	if musicDict.has(type):
		var music: MusicResource = musicDict[type]
		
		musicPlayerRef.stream = music.music
		musicPlayerRef.volume_db = music.volume
		musicPlayerRef.play()
		
	else:
		push_error("Cannot find type ", type)

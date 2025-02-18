extends Resource
class_name MusicResource

enum MUSIC_TYPE {
	MENU_MUSIC,
	MAIN_MUSIC,
	PINCH_MUSIC
}

@export var musicType : MUSIC_TYPE
@export var music : AudioStreamMP3
@export_range(-50, 50) var volume : float = 0

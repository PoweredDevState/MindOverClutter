extends Resource
class_name MusicResource


#This resource script is for each different music type in the game
#This resource also contains a enum type of each music piece
#to easily verify the music type for the music manager

#SoundResource script based on Aarimous' AudioManager project
#Video Link: https://www.youtube.com/watch?v=Egf2jgET3nQ&list=PLPa54potuqXIjxpqrhlXBvJYa7Vu2p_x_&index=5 
#GitHub Link: https://github.com/Aarimous/AudioManager
enum MUSIC_TYPE {
	MENU_MUSIC,
	MAIN_MUSIC,
	PINCH_MUSIC
}

@export var musicType : MUSIC_TYPE
@export var music : AudioStreamMP3
@export_range(-50, 50) var volume : float = 0

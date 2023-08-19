extends AudioStreamPlayer2D

func _ready():
	play_song(preload("res://Sounds/BackgroundMusic.ogg"))

func play_song(source: AudioStreamOggVorbis):
	source.loop = true
	stream = source
	play()

extends Node2D

onready var sfx_player = get_node("SFXPlayer")
onready var music_player = get_node("BGMusicPlayer")
onready var minigame_music_player = get_node("MiniGameMusicPlayer")

var cooking_music
var scavenging_music

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func playSFX(stream : AudioStream):
	sfx_player.stream = stream
	sfx_player.play()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

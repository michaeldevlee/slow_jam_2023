extends Node2D

onready var sfx_player = get_node("SFXPlayer")
onready var music_player = get_node("BGMusicPlayer")
onready var minigame_music_player = get_node("MiniGameMusicPlayer")

var cooking_music = preload("res://Audio/Cooking music shop music.wav")
var scavenging_music = preload("res://Audio/Nightime Sneak.wav")
var start_menu_music = null

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func playSFX(stream : AudioStream):
	sfx_player.stream = stream
	sfx_player.play()

func playBG(stream : AudioStream):
	music_player.stream = stream
	music_player.play()

func playMiniGameMusic(stream : AudioStream):
	minigame_music_player.stream = stream
	minigame_music_player.play()

extends Node2D

onready var sfx_player = get_node("SFXPlayer")
onready var music_player = get_node("BGMusicPlayer")
onready var minigame_music_player = get_node("MiniGameMusicPlayer")

var cooking_music = preload("res://Audio/Cooking music shop music.wav")
var cooking_music2 = preload("res://Audio/Noodle Pull Correct.wav")
var cooking_music3 = preload("res://Audio/Seaweed Wrap.wav")
var scavenging_music = preload("res://Audio/Nightime Sneak.wav")
var start_menu_music = preload("res://Audio/Cooking Theme.mp3")
var ending_music = preload("res://Audio/funky_space_time.wav")

var close_inv = preload("res://Audio/Close Inventory.wav")
var open_inv = preload("res://Audio/Open Inventory .wav")
var meatball_grow = preload("res://Audio/GrowingMeatball2.wav")
var metaball_grow_2 = preload("res://Audio/Meatball Big.wav")
var noodle_pull_correct = preload("res://Audio/Noodle Pull Correct.wav")
var seaweed_wrap = preload("res://Audio/Seaweed Wrap.wav")
var shrink = preload("res://Audio/Shrinking1.wav")
var siren = preload("res://Audio/siren.mp3")
var sizzle = preload("res://Audio/Sizzle1.wav")
var step = preload("res://Audio/Step.mp3")
var caught = preload("res://Audio/You're a thief!.wav")
var sale = preload("res://Audio/Sale.wav")
var give_up = preload("res://Audio/I_Give_up.wav")
var digging_trash = preload("res://Audio/digging_through_the_trash.wav")
var new_item = preload("res://Audio/New_Item.wav")
var just_item = preload("res://Audio/Just_Item.wav")
var disgruntled_customer = preload("res://Audio/Bad_Service.wav")

var rng = RandomNumberGenerator.new()
var indexes = [0, 1, 2]

var cooking_songs = []

# Called when the node enters the scene tree for the first time.
func _ready():
	rng.randomize()
	cooking_songs =[
	cooking_music,
	cooking_music2,
	cooking_music3
]
	music_player.connect("finished", self, "play_random_cooking_song")

func playSFX(stream : AudioStream, volume : int = -2):
	sfx_player.stream = stream
	sfx_player.volume_db = volume
	sfx_player.play()

func playBG(stream : AudioStream, volume : int = -10):
	music_player.stream = stream
	sfx_player.volume_db = volume	
	music_player.play()

func playMiniGameMusic(stream : AudioStream, volume : int = -5):
	minigame_music_player.stream = stream
	sfx_player.volume_db = volume	
	minigame_music_player.play()

func stop_all():
	sfx_player.stop()
	music_player.stop()
	minigame_music_player.stop()


func play_random_cooking_song():
	if GameState.current_mode == "cooking":
		var rand_int = rng.randi_range(0, cooking_songs.size()-1)
		playBG(cooking_songs[rand_int])
		cooking_songs.pop_at(rand_int)
		print(rand_int)
		print(cooking_songs)
		if cooking_songs.size() <= 0:
			cooking_songs = [cooking_music, cooking_music2, cooking_music3]
		print('called')

func _process(delta):
	if Input.is_action_just_pressed("ui_down"):
		play_random_cooking_song()

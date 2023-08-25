extends Node2D

onready var timer = get_node("Timer")
onready var sceneManager = get_node("SceneManager")
onready var HUD = get_node("HUD")

var game_cycle_time = 10

func _ready():
	timer.connect("timeout", self, "enter_next_mode")
	InteractEventBus.connect("skip_initiated", self, "enter_next_mode")

func enter_next_mode():
	sceneManager.next()
	timer.stop()
	timer.wait_time = game_cycle_time

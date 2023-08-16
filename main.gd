extends Node2D

onready var timer = get_node("Timer")
onready var sceneManager = get_node("SceneManager")

func _ready():
	timer.connect("timeout", self, "enter_next_mode")

func enter_next_mode():
	sceneManager.next()

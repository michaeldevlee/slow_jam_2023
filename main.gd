extends Node2D

onready var timer = get_node("Timer")
onready var sceneManager = get_node("SceneManager")
onready var HUD = get_node("HUD")
onready var time_display = get_node("Control/TimeDisplay")

var game_cycle_time = 120
var cash_to_win = 1000
var ending_screen = preload("res://UI/EndCredits.tscn")

func _ready():
	timer.connect("timeout", self, "enter_next_mode")
	InteractEventBus.connect("switch_mode_initiated", self, "enter_next_mode")
	InteractEventBus.connect("skip_initiated", self, "enter_next_mode")
	InteractEventBus.connect("check_if_game_over", self, "check_if_game_over")
	InteractEventBus.connect("tutorial_over", self, "start_timer")

func start_timer():
	timer.start()

func check_if_game_over():
	if Inventory.money >= cash_to_win:
		var ending_instance = ending_screen.instance()
		add_child(ending_instance)

func enter_next_mode():
	check_if_game_over()
	sceneManager.next()
	timer.stop()
	timer.wait_time = game_cycle_time
	timer.start()

func _process(delta):
	time_display.set_text(str("%d" % timer.time_left))


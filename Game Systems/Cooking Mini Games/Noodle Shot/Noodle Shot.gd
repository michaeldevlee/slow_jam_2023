extends MiniGame

onready var frying_pan = get_node("Area2D")
onready var noodles_root = get_node("Position2D")
onready var noodle_timer = get_node("NoodleTimer")
onready var remove_area = get_node("RemoveArea")
onready var game_timer = get_node("Timer")

var drop : bool = true
var score = 0
var noodle = preload("res://Game Systems/Cooking Mini Games/Noodle Shot/Noodles.tscn")
var rng = RandomNumberGenerator.new()

func _ready():
	remove_area.connect("area_entered", self, "remove_noodle")
	noodle_timer.connect("timeout", self, "spawn_noodle")
	frying_pan.connect("area_entered", self, "handleFry")
	game_timer.connect("timeout", self, "end_mini_game")

func handleFry(body):
	if body is Noodle:
		if !body.isBadNoodle:
			score += 1
		else:
			score -= 1

func checkScore(score):
	if recipe:
		if score >= 9:
			set_reward_type("big")
		elif score > 5 && score < 9:
			set_reward_type("medium")
		else:
			set_reward_type("basic")

func spawn_noodle():
	rng.randomize()
	var noodle_instance = noodle.instance()
	noodle_instance.speed = 150
	
	noodles_root.add_child(noodle_instance)

func remove_all_noodles():
	for noodle in noodles_root.get_children():
		noodle.queue_free()

func remove_noodle(body):
	body.queue_free()

func cleanup():
	noodle_timer.stop()
	remove_all_noodles()
	
func end_mini_game():
	checkScore(score)
	noodle_timer.stop()
	remove_all_noodles()
	notify_mini_game_ended()

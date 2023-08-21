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
	if score >= 9:
		print("high reward")
	elif score > 5 && score < 9:
		print("medium reward")
	else:
		print("base reward")

func spawn_noodle():
	rng.randomize()
	var noodle_instance = noodle.instance()
	noodle_instance.speed = 150
	
	noodles_root.add_child(noodle_instance)

func remove_noodle(body):
	print(body)
	body.queue_free()

func end_mini_game():
	checkScore(score)
	notify_mini_game_ended()

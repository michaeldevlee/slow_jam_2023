extends MiniGame

onready var done_area = get_node("Done_Pile")
onready var timer = get_node("Timer")

var score : int = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	done_area.connect("area_entered", self, "process_meteor")
	timer.connect("timeout", self, "end_mini_game")
	
	for meteor in get_children():
		if meteor is Meteor:
			meteor.connect("picked_up", self, "disable")
			meteor.connect("dropped", self, "enable")

func disable():
	for meteor in get_children():
		if meteor is Meteor and meteor.picked_up == false:
			meteor.input_pickable = false

func enable():
	for meteor in get_children():
		if meteor is Meteor and meteor.cooking == false:
			meteor.input_pickable = true

func add_point():
	score += 1

func process_meteor(area):
	if area.cooked:
		area.cleanup()
		add_point()

func check_score(score):
	if score > 5:
		set_reward_type("big")
	elif score > 3:
		set_reward_type("medium")
	else:
		set_reward_type("basic")
		
func end_mini_game():
	check_score(score)
	notify_mini_game_ended()

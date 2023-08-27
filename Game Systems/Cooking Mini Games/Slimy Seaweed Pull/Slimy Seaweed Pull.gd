extends MiniGame

onready var wrap_root = get_node("Wraps")
onready var timer = get_node("Timer")

var score : int = 0
var curr_wrap = null

var locations = {
	"NORTH":Vector2(120,-48),
	"SOUTH":Vector2(120,192),
	"EAST":Vector2(344,72),
	"WEST":Vector2(-104,72)
}

var wrap = preload("res://Game Systems/Cooking Mini Games/Slimy Seaweed Pull/Slimy Seaweed Wrap.tscn")
var rng = RandomNumberGenerator.new()

func _ready():
	wrap_root.connect("child_entered_tree", self, "connect_wrap_signal")
	timer.connect("timeout", self, "end_mini_game")
	create_wrap()
	
func create_wrap():
	rng.randomize()
	if curr_wrap and curr_wrap.properly_wrapped == true:
		add_point()
	
	var direction = locations.keys()[rng.randi_range(0,locations.size()-1)]
	var wrap_instance = wrap.instance()
	wrap_instance.orientation = direction
	wrap_instance.position = locations[direction]
	wrap_root.add_child(wrap_instance)
	curr_wrap = wrap_instance

func connect_wrap_signal(wrap):
	wrap.connect("wrap_placed", self, "create_wrap")

func add_point():
	score += 1
	print("your score is " + str(score))

func check_score(score):
	if score > 8:
		set_reward_type("big")
	elif score > 5:
		set_reward_type("medium")
	else:
		set_reward_type("basic")

func end_mini_game():
	check_score(score)
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	notify_mini_game_ended()

func _process(delta):
	if Input.is_action_just_pressed("ui_down"):
		create_wrap()

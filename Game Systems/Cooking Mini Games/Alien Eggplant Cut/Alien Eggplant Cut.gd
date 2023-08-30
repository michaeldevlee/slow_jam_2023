extends MiniGame

onready var circle = get_node("SelectionArea/CollisionShape2D")
onready var circle_sprite = get_node("SelectionArea/Sprite3")
onready var eggplant_root = get_node("Eggplants")
onready var eggplant_timer = get_node("Eggplant_Timer")
onready var timer = get_node("Timer")

var drawing : bool = false
var original_mos_pos = Vector2()
var original_collision_radius
var eggplant = preload("res://Game Systems/Cooking Mini Games/Alien Eggplant Cut/Alien Eggplant.tscn")
var rng = RandomNumberGenerator.new()

var score : int = 0 

func _ready():
	rng.randomize()
	original_collision_radius = circle.shape.radius
	eggplant_timer.connect("timeout", self, "spawn_eggplant")
	timer.connect("timeout", self, "end_mini_game")

func spawn_eggplant():
	var eggplant_instance = eggplant.instance()
	var rand_x = rng.randi_range(30, 200)
	var rand_y = rng.randi_range(30, 150)
	
	eggplant_instance.global_position = Vector2(rand_x, rand_y)
	eggplant_instance.connect("cut_off", self, "add_score")
	eggplant_root.add_child(eggplant_instance)
func _unhandled_input(event):
	if Input.is_action_just_pressed("mouse_interact"):
		drawing = true
		circle.disabled = false
		circle.shape.radius = 1
		circle_sprite.scale = Vector2(1,1)
		circle_sprite.global_position = get_global_mouse_position()
		circle.global_position = get_global_mouse_position()
		original_mos_pos = get_global_mouse_position()
		Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	elif Input.is_action_just_released("mouse_interact"):
		drawing = false
		circle.disabled = true
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	
	if event is InputEventMouseMotion:
		if drawing and circle.shape.radius < 25:
			circle.shape.radius += 4
			
			var target_scale = circle.shape.radius / original_collision_radius * 0.7
			
			circle_sprite.scale = Vector2(target_scale,target_scale)

func add_score():
	score += 1
	
func check_score(score):
	if score > 20:
		set_reward_type("big")
	elif score > 15:
		set_reward_type("medium")
	else:
		set_reward_type("basic")

func end_mini_game():
	check_score(score)
	notify_mini_game_ended()

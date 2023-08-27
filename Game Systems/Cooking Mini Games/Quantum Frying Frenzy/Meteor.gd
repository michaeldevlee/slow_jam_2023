extends Selectable
class_name Meteor

onready var anim_player = get_node("AnimationPlayer")
onready var done_label = get_node("Label")

var picked_up : bool = false
var can_cook : bool = false
var cooked : bool = false setget display_done
var cooking : bool = false
var frying_pan 

signal cooking_mode_init
signal done_cooking
signal picked_up
signal dropped

func _ready():
	connect("area_entered", self, "capture_frying_pan")
	connect("area_exited", self, "disconnect_frying_pan")

func interact():
	if !picked_up and input_pickable:
		picked_up = true
		emit_signal("picked_up")

func capture_frying_pan(area : Area2D):
	if area.is_in_group("Frying_Pan"):
		frying_pan = area

func disconnect_frying_pan(area):
	if area.is_in_group("Frying_Pan"):
		frying_pan = null
		
func handlePickUp():
	if picked_up:
		Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
		global_position = get_global_mouse_position()

func handleDrop():
	if can_cook and !cooked and frying_pan:
		frying_pan.start_cooking(self)
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	picked_up = false
	emit_signal("dropped")

func _unhandled_input(event):
	if Input.is_action_just_released("mouse_interact") and picked_up:
		handleDrop()

func display_done(val):
	anim_player.play("Done")
	cooked = val

func cleanup():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	picked_up = false
	emit_signal("dropped")
	queue_free()

func _process(delta):
	handlePickUp()

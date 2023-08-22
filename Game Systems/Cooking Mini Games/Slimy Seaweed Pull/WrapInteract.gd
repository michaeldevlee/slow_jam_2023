extends Selectable

onready var grab_spot = get_node("GrabSpot")

var selected = false
var can_interact = false
var wrap
var new_position = 0
var original_position 
var original_mouse_pos

signal reset_mouse

func _ready():
	connect("mouse_entered", self, "toggle_selected", [true])
	connect("mouse_exited", self, "toggle_selected", [false])

	if get_parent():
		wrap = get_parent()
		original_position = wrap.global_position
		Input.warp_mouse_position(grab_spot.global_position)

func interact():
	if get_parent():
		selected = !selected
		
func toggle_selected(status):
	can_interact = status

func handleSelect():
	if selected:
		wrap.global_position.x = wrap.global_position.x + new_position

func _unhandled_input(event):
	
	if event is InputEventMouseButton and event.is_action_pressed("mouse_interact") and can_interact:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		selected = true
	elif event is InputEventMouseButton and event.is_action_released("mouse_interact"):
		selected = false
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	elif event is InputEventMouseMotion and selected:
		if wrap.global_position.x > -200:
			new_position = event.relative.x
		else:
			wrap.global_position.x = -170

		if wrap.global_position.x < 50:
			new_position = event.relative.x
		else:
			wrap.global_position.x = 20
		
func _process(delta):
	handleSelect()
	

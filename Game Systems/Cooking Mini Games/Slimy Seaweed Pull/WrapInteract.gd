extends Selectable

onready var grab_spot = get_node("GrabSpot")

var selected = false
var can_interact = false
var wrap
var new_position = Vector2()
var original_position 
var original_mouse_pos
var orientation

const MAX_HORZ_DISTANCE = 300
const MAX_VERT_DISTANCE = 200

var already_put_down = false


signal reset_mouse

func _ready():
	connect("mouse_entered", self, "toggle_selected", [true])
	connect("mouse_exited", self, "toggle_selected", [false])

	if get_parent():
		wrap = get_parent()
		original_position = wrap.global_position

func interact():
	if get_parent() and can_interact:
		selected = !selected
		
func toggle_selected(status):
	can_interact = status

func handleSelect():
	if selected:
		wrap.global_position = wrap.global_position + new_position

func _unhandled_input(event):
	if can_interact:
		if event is InputEventMouseButton and event.is_action_pressed("mouse_interact"):
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
			selected = true
		elif event is InputEventMouseButton and event.is_action_released("mouse_interact") :
			already_put_down = true
			selected = false
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
			wrap.emit_signal("wrap_placed")
			queue_free()
		elif event is InputEventMouseMotion and selected:
			new_position = event.relative
		
func _process(delta):
	handleSelect()
	

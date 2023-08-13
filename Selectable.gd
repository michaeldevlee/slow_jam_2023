extends Area2D
class_name Selectable

func _ready():
	connect("input_event", self, "initiate_event")

func initiate_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		if event.is_pressed() and get_parent():
			interact()

func interact():
	pass


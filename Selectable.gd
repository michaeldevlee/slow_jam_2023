extends Node

onready var parent = get_parent()

func _ready():
	if parent and parent is CollisionObject2D and get_parent().input_pickable:
		parent.connect("input_event", parent, "test")
		print(parent)

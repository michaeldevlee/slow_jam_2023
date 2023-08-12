extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	for node in get_children():
		if node is CollisionObject2D && node.input_pickable:
			node.connect("selected", self, "handleSelect")

func handleSelect(pickedObject):
	print(pickedObject.name)

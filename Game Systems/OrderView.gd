extends Control

export var ingredient_icons : NodePath
export var order_title : NodePath
export var recipe_icon : NodePath

export var _exit_button : NodePath
var exit_button

func _ready():
	if _exit_button:
		exit_button = get_node(_exit_button)
		exit_button.connect("pressed", self, "exit")

func load_order(recipe : Recipe):
	pass

func exit():
	visible = false
	print("exit")

extends ColorRect

func _ready():
	for action in get_children():
		if action is ActionChange and action.action == "SIGNAL":
			action.connect("customer_arrived", self, "add_recipe")

func add_recipe(action : ActionChange):
	print('add new recipe')


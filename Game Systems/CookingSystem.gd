extends Node2D
class_name CookingSystem

onready var navbar = get_node("BlockOut/ColorRect2/Navbar")
onready var order_view = get_node("UI")

func _ready():
	navbar.navbar_list.connect("child_entered_tree", self, "connect_recipe")

func connect_recipe(recipe : Recipe):
	recipe.connect("recipe_selected", self, "view_recipe")

func load_order(recipe : Recipe):
	pass

func view_recipe(recipe : Recipe):
	order_view.visible = true
	print("We need " + GameState.available_ingredients[recipe.order.required_ingredients])
	
	

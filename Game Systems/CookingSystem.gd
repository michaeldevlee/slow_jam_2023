extends Node2D
class_name CookingSystem

onready var navbar = get_node("BlockOut/ColorRect2/Navbar")
onready var order_view = get_node("UI")
onready var open_ui_button = get_node("BlockOut/ColorRect2/Slide Out Button")
onready var anim_plyer = get_node("AnimationPlayer")

func _ready():
	navbar.navbar_list.connect("child_entered_tree", self, "connect_recipe")
	open_ui_button.connect("button_up", self, "open_navbar")
	navbar.connect("navbar_exited", self, "close_navbar")

func connect_recipe(recipe : Recipe):
	recipe.connect("recipe_selected", self, "view_recipe")

func view_recipe(recipe : Recipe):
	order_view.load_order(recipe)
	var ingredients = recipe.order.required_ingredients
	for ingredient in ingredients:
		print(ingredient.name)
	order_view.visible = true

func open_navbar():
	anim_plyer.play("show_nav_bar")
	open_ui_button.visible = false
	navbar.init_navbar()
	
func close_navbar():
	anim_plyer.play("close_nav_bar")
	open_ui_button.visible = true
	

extends Node2D
class_name CookingSystem

onready var navbar = get_node("BlockOut/ColorRect2/Navbar")
onready var recipe_view = get_node("UI/PopUpBackground/RecipeManagement")
onready var modal = get_node("UI")
onready var open_ui_button = get_node("BlockOut/ColorRect2/Slide Out Button")
onready var anim_plyer = get_node("AnimationPlayer")

func init():
	set_process_input(true)

func _ready():
	navbar.navbar_list.connect("child_entered_tree", self, "connect_recipe")
	open_ui_button.connect("button_up", self, "open_navbar")
	navbar.connect("navbar_exited", self, "close_navbar")
	InteractEventBus.connect("mini_game_ended", self, "process_mini_game")

func connect_recipe(recipe : Recipe):
	recipe.connect("recipe_selected", self, "view_recipe")

func view_recipe(recipe : Recipe):
	modal.load_order(recipe)
	var ingredients = recipe.order.required_ingredients
	recipe_view.visible = true
	modal.visible = true

func open_navbar():
	anim_plyer.play("show_nav_bar")
	open_ui_button.visible = false
	navbar.init_navbar()
	
func close_navbar():
	anim_plyer.play("close_nav_bar")
	open_ui_button.visible = true

func process_mini_game(finished_recipe : Recipe):
	var recipe_resource = finished_recipe.order
	modal.exit()
	Inventory.money += recipe_resource.reward
	print(Inventory.money )
	finished_recipe.queue_free()

func cleanup():
	close_navbar()
	navbar.cleanup_navbar()
	modal.exit()
	set_process_input(false)
	set_process(false)
	

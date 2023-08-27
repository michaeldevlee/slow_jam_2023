extends Node2D
class_name CookingSystem

onready var navbar = get_node("BlockOut/CustomerArea/Navbar")
onready var recipe_view = get_node("UI/PopUpBackground/RecipeManagement")
onready var modal = get_node("UI")
onready var open_ui_button = get_node("BlockOut/CustomerArea/Slide Out Button")
onready var anim_plyer = get_node("AnimationPlayer")
onready var customer_arrival_point = get_node("BlockOut/CustomerArea/KitchenAction")
onready var customer_timer = get_node("Timer")
onready var customer_spawn_point = get_node("BlockOut/CustomerArea/Customer Start Point")
onready var customer_area = get_node("BlockOut/CustomerArea/Customers")
onready var score_display = get_node("Label")

var recipe_scene = preload("res://Game Systems/Recipe.tscn")
var customer_scene = preload("res://Game Systems/Customer.tscn")

var max_order_count = 3
var order_count = 0


func init():
	customer_timer.wait_time = 3
	customer_timer.start()
	

func _ready():
	navbar.navbar_list.connect("child_entered_tree", self, "connect_recipe")
	open_ui_button.connect("button_up", self, "open_navbar")
	navbar.connect("navbar_exited", self, "close_navbar")
	InteractEventBus.connect("mini_game_ended", self, "process_mini_game")
	customer_timer.connect("timeout", self, "spawn_customer")
	
	init()
	
	if customer_arrival_point.action == "SIGNAL":
		customer_arrival_point.connect("customer_arrived", self, "recipe_init")

func recipe_init(customer_action : Customer):
	if customer_action.order is Recipe_Order and order_count < max_order_count:
		order_count += 1
		var recipe_instance : Recipe = recipe_scene.instance()
		recipe_instance.order = customer_action.order
		recipe_instance.customer = customer_action
		navbar.order_init(recipe_instance)
		customer_action.changeDirectionTo(Vector2(0, -16), "UP")
		customer_action.busy = false
		

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
	finished_recipe.customer.queue_free()
	modal.exit()
	Inventory.money += recipe_resource.reward
	score_display.set_text(recipe_resource.reward_type + " reward \n" + "+" + str(recipe_resource.reward) )
	anim_plyer.play("display_score")
	finished_recipe.queue_free()
	open_order_slot()

func open_order_slot():
	order_count -= 1

func spawn_customer():
	var customer = customer_scene.instance()
	customer.global_position = customer_spawn_point.position
	customer_area.add_child(customer)

func reset_customers():
	for customer in customer_area.get_children():
		customer.queue_free()
	
	customer_timer.stop()
func cleanup():
	close_navbar()
	navbar.cleanup_navbar()
	modal.exit()
	reset_customers()
	
func _process(delta):
	if Input.is_action_just_pressed("toggle_navbar"):
		if open_ui_button.visible == true:
			open_navbar()
		else:
			close_navbar()	

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
onready var tutorial = get_node("Tutorial")
onready var modal_background = get_node("ColorRect")

var tutorial_mode : bool = true

var recipe_scene = preload("res://Game Systems/Recipe.tscn")
var customer_scene = preload("res://Game Systems/Customer.tscn")

var max_order_count = 3
var order_count = 0

func init():
	if !tutorial_mode:
		customer_timer.wait_time = 10
		customer_timer.start()
		
	else:
		anim_plyer.play("play_tutorial")
	AudioEngine.play_random_cooking_song()
	
func _ready():
	modal_background.visible = false
	navbar.navbar_list.connect("child_entered_tree", self, "connect_recipe")
	open_ui_button.connect("button_up", self, "open_navbar")
	navbar.connect("navbar_exited", self, "close_navbar")
	InteractEventBus.connect("mini_game_ended", self, "process_mini_game")
	InteractEventBus.connect("tutorial_over", self, "stop_tutorial")
	InteractEventBus.connect("order_view_closed", self , "remove_modal_background")
	customer_timer.connect("timeout", self, "spawn_customer")
	DialogueManager.connect("dialogue_finished", self, "unpause_anim_player")
	DialogueManager.connect("dialogue_started", self, "pause_anim_player")
	init()
	
	if customer_arrival_point.action == "SIGNAL":
		customer_arrival_point.connect("customer_arrived", self, "recipe_init")

func pause_anim_player():
	anim_plyer.stop(false)
	
func unpause_anim_player(event):
	anim_plyer.play()
		
func stop_tutorial():
	if tutorial_mode:
		tutorial_mode = false
		GameState.tutorial_mode = false
		tutorial.queue_free()
		InteractEventBus.emit_signal("skip_initiated")

func recipe_init(customer_action):
	if customer_action.order is Recipe_Order and order_count < max_order_count:
		order_count += 1
		var recipe_instance : Recipe = recipe_scene.instance()
		recipe_instance.order = customer_action.order
		recipe_instance.set_customer(customer_action)
		navbar.order_init(recipe_instance)
		customer_action.changeDirectionTo(Vector2(0, -16), "UP")
		customer_action.busy = false
		

func connect_recipe(recipe : Recipe):
	recipe.connect("recipe_selected", self, "view_recipe")

func view_recipe(recipe : Recipe):
	modal_background.visible = true
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
	modal_background.visible = false

func process_mini_game(finished_recipe : Recipe):
	modal_background.visible = false
	var recipe_resource = finished_recipe.order
	finished_recipe.customer.queue_free()
	modal.exit()
	AudioEngine.playSFX(AudioEngine.sale)
	Inventory.money += recipe_resource.reward
	score_display.set_text(recipe_resource.reward_type + " reward \n" + "+" + str(recipe_resource.reward) )
	InteractEventBus.emit_signal("check_if_game_over")
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

func remove_modal_background():
	modal_background.visible = false

func cleanup():
	close_navbar()
	order_count = 0
	navbar.cleanup_navbar()
	modal.exit()
	reset_customers()
	modal_background.visible = false


func _process(delta):
	if Input.is_action_just_pressed("toggle_navbar"):
		if !GameState.tutorial_mode:
			if open_ui_button.visible == true:
				open_navbar()
			else:
				close_navbar()	
	

func open_nav_bar_tutorial():
	pass

extends Node2D

var order_view_events = ["SHOW_NAV_BAR", "SHOW_RECIPE_ORDER", "SHOW_ORDER_VIEW"]
var navbar_list
export var recipe_list : NodePath

func _ready():
	if recipe_list:
		navbar_list = get_node(recipe_list)
		navbar_list.connect("child_entered_tree", self, "connect_recipe")
		
	DialogueManager.connect("dialogue_finished", self, "start_next_action")

func connect_recipe(recipe : Recipe):
	recipe.connect("recipe_selected", self, "start_order_intro")

func start_initial_dialogue():
	var char_name = "McSlime"
	var message = [
		"Oh hi! You opened up a new joint right?", 
		"I'm McSlime, and I'm your guide to this cooking frenzy.", 
		"Let me get a little closer!"]
	DialogueManager.init(char_name, message, order_view_events)

func start_nav_bar_intro():
	var char_name = "McSlime"
	var message = [
		"This is your order list!", 
		"It's currently because.. you have no customers. Sad.", 
		"Let me order a Singular Scrap Stew from you."
		]
	print('started showing nav bar')
	DialogueManager.init(char_name, message, order_view_events)
		
func start_order_list_intro():
	var order = preload("res://Interact System/Cooking_System/Recipe_Tutorial/Singular Scrap Stew_Tutorial.tscn")
	var order_instance = order.instance()
	
	navbar_list.add_child(order_instance)
	
	var char_name = "McSlime"
	var message = [
		"Look at your order list, a brand new order showed up!", 
		"Try, left clicking on the order!"
		]
	print('started showing order')
	DialogueManager.init(char_name, message, order_view_events)

func start_order_intro(recipe):
	var char_name = "McSlime"
	var message = [
		"You are now viewing an order!", 
		"You can add ingredients by pressing on the icons in the middle.", 
		"But.. it looks like you don't have anything.",
		"Looks like you're gonna have to get creative..",
		"Like, y'know, dig through some trash cans..",
		"Everyone does it.. another man's trash is..",
		"You know the story! Now go downstairs and gather some trash!",
		"You have hungry customers"
		]
	var event = ["START_GAME"]
	print('started showing nav bar')
	DialogueManager.init(char_name, message, event)

func start_next_action(event):
	if event[0] == "START_GAME":
		InteractEventBus.emit_signal("tutorial_over")


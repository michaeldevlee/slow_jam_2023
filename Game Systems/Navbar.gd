extends ColorRect

var recipe = preload("res://Interact System/Cooking_System/Recipes/Junkyard Jamboree Stew/Junkyard Jamboree Stew.tscn")
var navbar_list
export var recipe_list : NodePath

onready var exit_button = get_node("Slide Out Button2")

signal navbar_exited

func _ready():
	exit_button.connect("button_up", self, "cleanup_navbar")
	
	if recipe_list:
		navbar_list = get_node(recipe_list)
		navbar_list.connect("child_exiting_tree", self, "cleanup_order")
		navbar_list.connect("child_entered_tree", self, "load_order")

func init_navbar():
	exit_button.visible = true

func cleanup_navbar():
	exit_button.visible = false
	emit_signal("navbar_exited")

func load_order(s):
	if s is Recipe:
		pass

func cleanup_order(s):
	if s is Recipe:
		pass

func _process(delta):
	if Input.is_action_just_pressed("ui_up"):
		var i_recipe = recipe.instance()
		navbar_list.add_child(i_recipe)

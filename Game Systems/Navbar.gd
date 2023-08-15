extends ColorRect

var recipe = preload("res://Interact System/Cooking_System/Recipes/Singular Scrap Stew/Singular Scrap Stew.tscn")
var navbar_list
export var recipe_list : NodePath

func _ready():
	if recipe_list:
		navbar_list = get_node(recipe_list)
		navbar_list.connect("child_exiting_tree", self, "cleanup_order")
		navbar_list.connect("child_entered_tree", self, "load_order")

func load_order(s):
	if s is Recipe:
		pass

func cleanup_order(s):
	if s is Recipe:
		pass

func _process(delta):
	if Input.is_action_just_pressed("ui_down"):
		if $Recipe:
			$Recipe.queue_free()
	if Input.is_action_just_pressed("ui_up"):
		var i_recipe = recipe.instance()
		navbar_list.add_child(i_recipe)

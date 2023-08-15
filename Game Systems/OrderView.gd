extends Control

export var ingredient_icons_path : NodePath
export var order_title_path : NodePath
export var recipe_icon_path : NodePath

var ingredient_icon
var order_title
var recipe_icon

var quantity_button = preload("res://Game Systems/IngredientButton.tscn")

export var _exit_button : NodePath
var exit_button

func _ready():
	if _exit_button:
		exit_button = get_node(_exit_button)
		exit_button.connect("pressed", self, "exit")
		
	if ingredient_icons_path and order_title_path and recipe_icon_path:
		ingredient_icon = get_node(ingredient_icons_path)
		order_title = get_node(order_title_path)
		recipe_icon = get_node(recipe_icon_path)

func load_order(recipe : Recipe):
	order_title.set_text(recipe.order.name)
	recipe_icon.set_texture(recipe.order.icon)
	for ingredient in recipe.order.required_ingredients:
		var texture = ingredient.icon
		var qty_button = quantity_button.instance()
		qty_button.texture_normal = texture
		ingredient_icon.add_child(qty_button)
	
	

func exit():
	visible = false
	print("exit")

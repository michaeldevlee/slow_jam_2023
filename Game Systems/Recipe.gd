extends TextureRect
class_name Recipe

signal recipe_selected (recipe)

export var order : Resource
var customer

onready var recipe_picture_root = get_node("MarginContainer/HBoxContainer/VBoxContainer")
onready var ingredient_icon_root = get_node("MarginContainer/HBoxContainer/VBoxContainer2")
onready var price_display_root = get_node("MarginContainer/HBoxContainer/VBoxContainer3")

var icon = preload("res://Game Systems/Icon.tscn")

func _ready():
	if order :
		var recipe_texture = order.mini_icon
		var icon_node = icon.instance()
		icon_node.type = "RECIPE"
		icon_node.texture = recipe_texture
		
		var req_ingredients = order.required_ingredients
		
		for ingredient in req_ingredients:
			var ingredient_icon = ingredient.mini_icon
			var ingredient_node = icon.instance()
			ingredient_node.type = "INGREDIENT"
			ingredient_node.texture = ingredient_icon
		
			ingredient_icon_root.add_child(ingredient_node)
		
		
		recipe_picture_root.add_child(icon_node)

func set_customer(customer):
	self.customer = customer 
		
		

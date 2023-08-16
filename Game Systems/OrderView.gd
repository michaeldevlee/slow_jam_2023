extends Control

export var mini_game_screen_path : NodePath
export var recipe_screen_path : NodePath
export var ingredient_icons_path : NodePath
export var enhancer_icons_path : NodePath
export var order_title_path : NodePath
export var recipe_icon_path : NodePath

var ingredient_icon
var order_title
var recipe_icon
var mini_game_screen
var recipe_screen
var enhancer_icon

var curr_recipe

var can_create_dish = false

var quantity_button = preload("res://Game Systems/IngredientButton.tscn")
onready var enhancer_button = get_node("PopUpBackground/RecipeManagement/RecipeSelect/RecipeSelect/Inner/VBoxContainer/Recipe Container/HBoxContainer/Enhancer Icons/Enhancer UI")

export var _start_button : NodePath
export var _exit_button : NodePath

var exit_button
var start_button
func _ready():
	if _exit_button and _start_button:
		exit_button = get_node(_exit_button)
		exit_button.connect("pressed", self, "exit")
		start_button = get_node(_start_button)
		start_button.connect("pressed", self, "initiate_mini_game_mode")
		
	if ingredient_icons_path and order_title_path and recipe_icon_path and mini_game_screen_path and recipe_screen_path and enhancer_icons_path:
		ingredient_icon = get_node(ingredient_icons_path)
		order_title = get_node(order_title_path)
		recipe_icon = get_node(recipe_icon_path)
		mini_game_screen = get_node(mini_game_screen_path)
		recipe_screen = get_node(recipe_screen_path)
		enhancer_icon = get_node(enhancer_icons_path)
	
	

func load_order(recipe : Recipe):
	curr_recipe = recipe
	order_title.set_text(curr_recipe.order.name)
	recipe_icon.set_texture(curr_recipe.order.icon)
	for ingredient in curr_recipe.order.required_ingredients:
		var texture = ingredient.icon
		var qty_button = quantity_button.instance()
		qty_button.texture_normal = texture
		if !Inventory.inventory.has(ingredient.name) || Inventory.inventory[ingredient.name] < 1:
			print("you dont have " + ingredient.name)
			qty_button.set_modulate(Color(0.2, 0.2, 0.5, 1))
			qty_button.get_child(0).set_text("0")
			can_create_dish = false
			
		
		qty_button.ingredient = ingredient.name
		ingredient_icon.add_child(qty_button)
	
func initiate_mini_game_mode():
	if can_create_dish:
		for icon in ingredient_icon.get_children():
			if Inventory.inventory.has(icon.ingredient):
				Inventory.inventory[icon.ingredient] -= icon.modal_inv
		
		if mini_game_screen is MiniGameScreen:
			mini_game_screen.visible = true
			recipe_screen.visible = false
			curr_recipe.order.enhancers.append(enhancer_button.selected_enhancer)
			mini_game_screen.start(curr_recipe)
		
func exit():
	for icon in ingredient_icon.get_children():
		icon.queue_free()
	visible = false
	can_create_dish = true
	curr_recipe = null

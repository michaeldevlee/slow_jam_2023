extends MiniGame

onready var ingredients_board = get_node("IngredientsBoard")
onready var ingredients_root = get_node("IngredientsBoard/MarginContainer/HFlowContainer")

export var rotten_meteor_marinara : Resource
export var quantum_batter : Resource 
export var rusty_meatball : Resource

export var last_level = 2

signal level_completed

var ingredients = []

var ingredient_icon = preload("res://Game Systems/Cooking Mini Games/Stack That Casserole/Ingredient_Icon.tscn")
var level = 0
var initial_ingredient_count = 2
var rng = RandomNumberGenerator.new()

func _ready():
	rng.randomize()
	
	ingredients = [ 
		rotten_meteor_marinara,
		quantum_batter,
		rusty_meatball
	]
	connect_buttons()
	load_level(level)

func load_level(level_number):
	if level_number < last_level:
		clear_ingredients_board()
		for i in (level_number + 2):
			var ran_ing : Ingredient = ingredients[rng.randi_range(0, 2)]
			var ing_instance = ingredient_icon.instance()
			ing_instance.texture = ran_ing.icon
			ing_instance.ingredient = ran_ing
			ingredients_root.add_child(ing_instance)
	else:
		disable_buttons()
		
	
func clear_ingredients_board():
	for ingredient in ingredients_root.get_children():		
		ingredient.queue_free()
		
func connect_buttons():
	for button in get_children():
		if button is TextureButton:
			button.connect("button_up", self, "add", [button])

func disable_buttons():
	for button in get_children():
		if button is TextureButton:
			button.disabled = true

func add(ingredient):	
	if ingredient.name == ingredients_root.get_children()[0].ingredient.name:
		ingredients_root.get_children()[0].set_modulate(Color(1,1,1,0.4))
		ingredients_root.remove_child(ingredients_root.get_child(0))	
		
	else:
		print('wrong1')
	if ingredients_root.get_children().size() == 0:
		print('end round')
		level += 1
		load_level(level)
		


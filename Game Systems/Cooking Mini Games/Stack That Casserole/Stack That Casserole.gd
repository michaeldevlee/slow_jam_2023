extends MiniGame

onready var ingredients_board = get_node("IngredientsBoard")
onready var ingredients_root = get_node("IngredientsBoard/MarginContainer/HFlowContainer")

export var rotten_meteor_marinara : Resource
export var quantum_batter : Resource 
export var rusty_meatball : Resource

signal level_completed

var ingredients = []
var queue

var ingredient_icon = preload("res://Game Systems/Cooking Mini Games/Stack That Casserole/Ingredient_Icon.tscn")
var level = 5
var last_level = 6
var initial_ingredient_count = 2
var rng = RandomNumberGenerator.new()

func _ready():
	rng.randomize()
	
	ingredients = [ 
		rotten_meteor_marinara,
		quantum_batter,
		rusty_meatball
	]
	
	load_level(level)
	for button in get_children():
		if button is TextureButton:
			button.connect("button_up", self, "add", [button.name])

func load_level(level_number):
	if level_number < last_level:	
		for i in (level_number + 2):
			var ran_ing : Ingredient = ingredients[rng.randi_range(0, 2)]
			var ing_instance = ingredient_icon.instance()
			ing_instance.texture = ran_ing.icon
			ing_instance.ingredient_name = ran_ing.name
			ingredients_root.add_child(ing_instance)
	
	queue = ingredients_root.get_children()
	
func add(ingredient_name):	
	if ingredient_name == queue[0].ingredient_name:
		var curr_ingredient = queue.pop_front()
		curr_ingredient.set_modulate(Color(1,1,1,0.4))
	else:
		print('wrong')
	
	if queue.size() == 0:
		print('end round')
		return


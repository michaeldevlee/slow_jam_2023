extends Node

export var all_recipes = []

var unlocked_recipes = []

export var available_ingredients = []

var unlocked_ingredients = []

export var available_enhancers = []

var unlocked_enhancers = []


func _ready():
	Inventory.connect("added_ingredient", self, "update_inventory_state")

func update_inventory_state(ingredient):
	if !unlocked_ingredients.has(ingredient):
		print("you got a new item: " + ingredient.name)
		var event = {
			"message" : "you got a new item: " + ingredient.name,
			"ingredient" : ingredient
		}
		InteractEventBus.emit_signal("pop_up_event_started", event)
		unlocked_ingredients.append(ingredient)
		update_available_recipes()

func update_available_recipes():
	for recipe in all_recipes:
		if recipe:
			var req_ingredients = recipe.required_ingredients
			var has_enough = true

			for ingredient in req_ingredients:
				if !unlocked_ingredients.has(ingredient):
					has_enough = false
					break
			if has_enough and !unlocked_recipes.has(recipe):
				print('you unlocked a new recipe called ' + recipe.name)
				var event = {
					"message" : "Unlocked new recipe: " + recipe.name,
					"ingredient" : recipe
					}
				InteractEventBus.emit_signal("pop_up_event_started", event)
				unlocked_recipes.append(recipe)



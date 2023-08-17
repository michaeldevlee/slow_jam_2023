extends Node

export var all_recipes = []

export var unlocked_recipes = []

export var available_ingredients = []

export var unlocked_ingredients = []

export var available_enhancers = []

export var unlocked_enhancers = []


func _ready():
	update_available_recipes()
	Inventory.connect("added_ingredient", self, "update_inventory_state")

func update_inventory_state(ingredient):
	if !unlocked_ingredients.has(ingredient):
		print("you got a new item: " + ingredient.name)
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
				unlocked_recipes.append(recipe)
		
				

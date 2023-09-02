extends Node

export var inventory : Dictionary

var money : int = 0

signal added_ingredient(ingredient)
signal removed_ingredient(ingredient)
signal check_if_game_over

func _ready():
	pass

func add(ingredient):
	if inventory.has(ingredient):
		inventory[ingredient] += 1;
	else:
		inventory[ingredient] = 0
		inventory[ingredient] += 1;
	emit_signal("added_ingredient", ingredient)
	InteractEventBus.emit_signal("check_if_game_over")

func remove(ingredient, quantity):
	if inventory.has(ingredient):
		inventory[ingredient] -= quantity;
	else:
		inventory[ingredient] = 0
	
	emit_signal("removed_ingredient", ingredient)
		

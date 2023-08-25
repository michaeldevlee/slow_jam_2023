extends Node

export var inventory : Dictionary
export var ing : Resource
export var ing2 : Resource

var money : int

signal added_ingredient(ingredient)

func _ready():
	pass

func add(ingredient):
	if inventory.has(ingredient):
		inventory[ingredient] += 1;
	else:
		inventory[ingredient] = 0
		inventory[ingredient] += 1;
	emit_signal("added_ingredient", ingredient)

func remove(ingredient):
		if inventory.has(ingredient):
			inventory.ingredient -= 1;
		else:
			inventory[ingredient] = 0
#
#func _process(delta):
#	if Input.is_action_just_pressed("ui_down"):
#		add(ing);
#	if Input.is_action_just_pressed("ui_up"):
#		add(ing2);
	

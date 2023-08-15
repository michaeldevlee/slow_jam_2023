extends Selectable
class_name Collectible

export var ingredient : Resource
onready var sprite = get_node("Sprite")

func interact():
	if !Inventory.inventory.has(ingredient.name):
		Inventory.inventory[ingredient.name] = 0
	
	Inventory.inventory[ingredient.name] += 1
	queue_free()
		


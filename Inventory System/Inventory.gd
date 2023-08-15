extends Node

export var inventory : Dictionary

func add(ingredient):
	if inventory.has(ingredient):
		inventory.ingredient -= 1;

func remove(ingredient):
		if inventory.has(ingredient):
			inventory.ingredient -= 1;
			

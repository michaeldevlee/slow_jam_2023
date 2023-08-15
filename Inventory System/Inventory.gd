extends Node

export var inventory : Dictionary

var money : int

func add(ingredient):
	if inventory.has(ingredient):
		inventory.ingredient -= 1;

func remove(ingredient):
		if inventory.has(ingredient):
			inventory.ingredient -= 1;
			

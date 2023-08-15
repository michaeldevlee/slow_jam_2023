extends Node

var inventory = {
	"SCRAPHEAD NOODLE" : 0
}

func add(ingredient):
	if inventory.has("SCRAPHEAD NOODLE"):
		print('have it')

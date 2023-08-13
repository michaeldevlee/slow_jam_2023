extends Selectable
class_name Collectible

export(String, "Scraphead Noodle", "Rusty Meatballs", "Slimy Seaweed Wrap", "Quantum Batter", "Rotten Meteor Marinara", "Alien Eggplant") var ingredient

func interact():
	if !Inventory.inventory.has(ingredient):
		Inventory.inventory[ingredient] = 0
	
	Inventory.inventory[ingredient] += 1
	queue_free()
		


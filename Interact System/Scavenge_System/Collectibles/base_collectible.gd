extends Selectable
class_name Collectible

export(String, "Scraphead Noodle", "Rusty Meatballs", "Slimy Seaweed Wrap", "Quantum Batter", "Rotten Meteor Marinara", "Alien Eggplant") var ingredient

func interact():
	print(ingredient)


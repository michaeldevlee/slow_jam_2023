extends TextureRect
class_name MiniGame

var recipe : Recipe

export (String, "None", "Rusty Relish", "Slimey Broth Reduction", " Scrapheap Salsa", "Alien Avocado Cream", "Quantum Ketchup") var compatible_condiment_1 = "None"
export (String, "None", "Rusty Relish", "Slimey Broth Reduction", " Scrapheap Salsa", "Alien Avocado Cream", "Quantum Ketchup") var compatible_condiment_2 = "None"

func notify_mini_game_ended():
	InteractEventBus.emit_signal("mini_game_ended", recipe)
	queue_free()

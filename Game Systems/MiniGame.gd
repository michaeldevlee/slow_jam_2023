extends TextureRect
class_name MiniGame

var recipe : Recipe

export (String, "None", "Rusty Relish", "Slimey Broth Reduction", " Scrapheap Salsa", "Alien Avocado Cream", "Quantum Ketchup") var compatible_condiment_1 = "None"
export (String, "None", "Rusty Relish", "Slimey Broth Reduction", " Scrapheap Salsa", "Alien Avocado Cream", "Quantum Ketchup") var compatible_condiment_2 = "None"

func notify_mini_game_ended():
	InteractEventBus.emit_signal("mini_game_ended", recipe)
	queue_free()

func set_reward_type(type):
	match type:
		"basic":
			recipe.order.set_reward_type("basic")
		"medium":
			recipe.order.set_reward_type("medium")
		"big":
			recipe.order.set_reward_type("big")
			

extends TextureRect
class_name MiniGame

var recipe : Recipe

export (String, "None", "Rusty Relish", "Slimey Broth Reduction", " Scrapheap Salsa", "Alien Avocado Cream", "Quantum Ketchup") var compatible_condiment_1 = "None"
export (String, "None", "Rusty Relish", "Slimey Broth Reduction", " Scrapheap Salsa", "Alien Avocado Cream", "Quantum Ketchup") var compatible_condiment_2 = "None"

onready var timer_display = get_node("Label")
onready var _timer = get_node("Timer")

func notify_mini_game_ended():
	InteractEventBus.emit_signal("mini_game_ended", recipe)
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	queue_free()

func set_reward_type(type):
	match type:
		"basic":
			recipe.order.set_reward_type("basic")
		"medium":
			recipe.order.set_reward_type("medium")
		"big":
			recipe.order.set_reward_type("big")
			

func _process(delta):
	timer_display.set_text(str("%d" % _timer.time_left))

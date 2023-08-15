extends MiniGame

onready var button = get_node("Button")

func _ready():
	button.connect("button_up", self, "end_game")

func end_game():
	InteractEventBus.emit_signal("mini_game_ended", recipe)
	queue_free()
	
	

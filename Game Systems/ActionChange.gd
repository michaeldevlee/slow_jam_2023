extends Area2D
class_name ActionChange

signal customer_arrived (message, action_change)

export (String, "MOVE", "SIGNAL", "STOP") var action = "MOVE"
export (String, "UP", "DOWN", "RIGHT", "LEFT") var toDirection = "DOWN"
var cast_to

func _ready():
	match toDirection:
		"UP":
			cast_to = Vector2(0, -16)
		"DOWN":
			cast_to = Vector2(0, 16)				
		"RIGHT":
			cast_to = Vector2(16, 0)				
		"LEFT":
			cast_to = Vector2(-16, 0)

func updateDirection(direction):
	action = "MOVE"
	toDirection = direction
	match toDirection:
		"UP":
			cast_to = Vector2(0, -16)
		"DOWN":
			cast_to = Vector2(0, 16)				
		"RIGHT":
			cast_to = Vector2(16, 0)				
		"LEFT":
			cast_to = Vector2(-16, 0)
	
		

func send_signal(message):
	emit_signal("customer_arrived", message)


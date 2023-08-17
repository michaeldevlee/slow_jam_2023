extends Area2D

onready var cast = get_node("RayCast2D")

export var canMove = false
export (String, "UP", "DOWN", "RIGHT", "LEFT") var direction = "DOWN"

var speed = 1

func checkIfAnyoneInFront():
		if cast.is_colliding():
			canMove = false
		else:
			canMove = true

func checkDirectionChange():
	var collider = cast.get_collider()
	
	if collider is ActionChange:
		match collider.action:
			"MOVE":
				var new_direction = collider.toDirection
				var new_cast_direction = collider.cast_to
				direction = new_direction
				cast.cast_to = new_cast_direction
			"SIGNAL":
				collider.send_signal()

func handleMove():
	if canMove:
		match direction:
			"UP":
				global_position.y -= speed
			"DOWN":
				global_position.y += speed			
			"RIGHT":
				global_position.x += speed		
			"LEFT":
				global_position.x -= speed
				
		

func _physics_process(delta):
	checkIfAnyoneInFront()
	handleMove()
	checkDirectionChange()
	

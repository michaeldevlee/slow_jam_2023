extends KinematicBody2D

export var speed = 30
onready var cast = get_node("RayCast2D")
onready var tween = get_node("Tween")

var velocity = Vector2()
export (String, "PATROL", "ALERT", "CHASE") var curr_state = "PATROL"
export (String, "UP", "DOWN", "LEFT", "RIGHT") var move_direction = "DOWN"

var patrolFrom : Vector2
export var patrolTo : Vector2

enum travel_states {TRAVELING_TO, TRAVELING_BACK}
var travel_status


func _ready():
	patrolFrom = position
	patrolTo = patrolFrom + patrolTo
	travel_status = travel_states.TRAVELING_TO

			
func switchState(state, delta):
	match state:
		"PATROL":
			if travel_status == travel_states.TRAVELING_TO:
				position = position.move_toward(patrolTo, delta*speed)
			
			if travel_status == travel_states.TRAVELING_BACK:
				position = position.move_toward(patrolFrom, delta*speed)
			
			if position == patrolTo:
				travel_status = travel_states.TRAVELING_BACK
			
			if position == patrolFrom:
				travel_status = travel_states.TRAVELING_TO				
		"ALERT":
			pass
		"CHASE":
			pass




func _physics_process(delta):
	switchState(curr_state, delta)
	
	if Input.is_action_just_pressed("ui_down"):
		curr_state = "ALERT"
	if Input.is_action_just_pressed("ui_up"):
		curr_state = "PATROL"
		

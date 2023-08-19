extends KinematicBody2D

export var speed = 30
onready var cast = get_node("RayCast2D")
onready var tween = get_node("Tween")
onready var sensingArea = get_node("SensingArea")
onready var chaseArea = get_node("ChaseArea")

var velocity = Vector2()
export (String, "PATROL", "ALERT", "CHASE") var curr_state = "PATROL"
export (String, "UP", "DOWN", "LEFT", "RIGHT") var move_direction = "DOWN"

var patrolFrom : Vector2
export var patrolTo : Vector2
var player : KinematicBody2D

enum travel_states {TRAVELING_TO, TRAVELING_BACK, }
var travel_status


func _ready():
	patrolFrom = position
	patrolTo = patrolFrom + patrolTo
	travel_status = travel_states.TRAVELING_TO
	sensingArea.connect("body_entered", self, "chase_if_confirmed")
	chaseArea.connect("body_exited", self, "go_back_to_patrol")

			
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
			position = position.move_toward(player.position, delta*speed)

func chase_if_confirmed(body):
	if body.name == "Player":
		curr_state = "CHASE"
		player = body

func go_back_to_patrol(body):
	if body.name == "Player":
		curr_state = "PATROL"
		player = null

func _physics_process(delta):
	switchState(curr_state, delta)
	
		

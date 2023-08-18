extends Area2D
class_name Customer

onready var cast = get_node("RayCast2D")
onready var timer = get_node("Timer")
export var canMove = false
export (String, "UP", "DOWN", "RIGHT", "LEFT") var direction = "DOWN"

var rng = RandomNumberGenerator.new()
var busy = false
var order
var speed = 0.4

func _ready():
	timer.connect("timeout", self, "getMad")
	var limit = GameState.unlocked_ingredients.size()-1
	rng.randomize()
	var rand = rng.randi_range(0, limit)
	order = GameState.unlocked_recipes[rand]

func getMad():
	set_modulate(Color(1,0,0,1))

func checkIfAnyoneInFront():
		if cast.get_collider():
			canMove = false
		else:
			canMove = true

func changeDirectionTo(new_cast_direction : Vector2, new_direction : String):
	cast.cast_to = new_cast_direction
	direction = new_direction

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
				if !busy:
					collider.send_signal(self)

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
	

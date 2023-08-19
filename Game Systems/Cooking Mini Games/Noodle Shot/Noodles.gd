extends Area2D

var velocity = Vector2()
var direction
export var speed = 10

func _ready():
	connect("input_event", self, "drop")

func drop(viewport, event , shape_idx):
	print(event)
	if event is InputEventMouseButton:
		direction = "DOWN"

func move(direction, delta):
	if direction == "DOWN":
		global_position.y += speed * delta
	else:
		global_position.x -= speed * delta

func _process(delta):
	move(direction, delta)

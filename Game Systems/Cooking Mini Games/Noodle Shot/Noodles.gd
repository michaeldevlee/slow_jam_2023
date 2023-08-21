extends Area2D
class_name Noodle

var velocity = Vector2()
var direction
export var speed = 10
var isBadNoodle = false
var rng = RandomNumberGenerator.new()

func _ready():
	connect("input_event", self, "drop")
	rng.randomize()
	
	if rng.randi() % 2:
		isBadNoodle = true

	if isBadNoodle:
		set_modulate(Color(1, 0.5, 0.5, 1))

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

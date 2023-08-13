extends KinematicBody2D

var speed = 100
var velocity = Vector2()

# Called when the node enters the scene tree for the first time.
func _ready():
	velocity.x = 200
	pass # Replace with function body.

func get_input():
	velocity = Vector2()
	if Input.is_action_pressed('ui_right'):
		velocity.x += 1
	elif Input.is_action_pressed('ui_left'):
		velocity.x -= 1
	elif Input.is_action_pressed('ui_down'):
		velocity.y += 1
	elif Input.is_action_pressed('ui_up'):
		velocity.y -= 1
	velocity = velocity.normalized() * speed


func _physics_process(delta):
	get_input()
	move_and_collide(velocity * delta)



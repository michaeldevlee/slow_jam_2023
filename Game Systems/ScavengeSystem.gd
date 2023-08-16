extends Node2D
class_name ScavengeSystem

onready var camera = get_node("Camera2D")
onready var player = get_node("Player")

func init():
	set_process_input(true)
	set_process(true)
	player.canMove = true
	camera.player = player
	camera.limit_left = -10000000
	camera.limit_top = -10000000
	camera.player = player
	player.global_position = Vector2()
func cleanup():
	set_process_input(false)	
	set_process(false)
	player.canMove = false
	camera.player = null
	camera.limit_left = 0
	camera.limit_top = 0
	camera.offset = Vector2()
	camera.global_position = Vector2()

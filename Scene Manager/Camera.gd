extends Camera2D

var player : KinematicBody2D

func follow_player():
	global_position = player.global_position

func _process(delta):
	if player:
		follow_player()

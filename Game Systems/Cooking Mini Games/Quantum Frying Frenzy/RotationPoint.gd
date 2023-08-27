extends Position2D

export var rotation_speed = PI

onready var meteor = get_node("Meteor")

func _process(delta):
	meteor.rotation += rotation_speed * delta

extends Node2D

onready var timer = get_node("Timer")

func _ready():
	timer.connect("timeout", self, "test")


func test():
	print('runngin')

extends Area2D
class_name FryingPan

onready var timer = get_node("Timer")
onready var collider = get_node("CollisionShape2D")

var activated : bool
var free : bool = true
var meteor

var cooking : bool = false

func _ready():
	connect("area_entered", self, "check_if_ready_to_cook")
	connect("area_exited", self, "disconnect_meteor")
	timer.connect("timeout", self, "notify_done_cooking")


func check_if_ready_to_cook(area):
	if area is Meteor and free:
		area.can_cook = true
		meteor = area
		
func disconnect_meteor(area):
	if area is Meteor and free:
		area.can_cook = false
		meteor = false

func start_cooking(meteor):
	if !cooking and free:
		collider.disabled = true
		self.free = false
		self.meteor = meteor
		cooking = true
		meteor.cooking = true
		timer.start()
		meteor.input_pickable = false
	

func notify_done_cooking():
	self.free = true
	self.cooking = false
	collider.disabled = false
	meteor.input_pickable = true
	meteor.cooking = false
	meteor.cooked = true
	meteor = null	

extends MiniGame

onready var done_area = get_node("Done_Pile")

# Called when the node enters the scene tree for the first time.
func _ready():
	done_area.connect("area_entered", self, "process_meteor")
	
	for meteor in get_children():
		if meteor is Meteor:
			meteor.connect("picked_up", self, "disable")
			meteor.connect("dropped", self, "enable")

func disable():
	for meteor in get_children():
		if meteor is Meteor and meteor.picked_up == false:
			meteor.input_pickable = false

func enable():
	for meteor in get_children():
		if meteor is Meteor and meteor.cooking == false:
			meteor.input_pickable = true

func process_meteor(area):
	if area.cooked:
		area.cleanup()

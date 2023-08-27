extends Sprite

var selected : bool = false
var selection_points 
var count = 0

signal cut_off

func _ready():
	selection_points = get_children().size()
	
	for area in get_children():
		area.connect("area_entered", self, "toggle_select", [true])
		area.connect("area_exited", self, "toggle_select", [false])

func toggle_select(area, status):
	if area.name == "SelectionArea":
		selected = status
		print('selected is '  + str(status))
	
		if selected:
			count += 1
		else:
			count -= 1
		
		if count == selection_points:
			queue_free()

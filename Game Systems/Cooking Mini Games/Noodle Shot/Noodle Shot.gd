extends MiniGame

onready var frying_pan = get_node("Area2D")
onready var noodles_root = get_node("Position2D")
onready var hit_points = get_node("HitPoints")

var drop : bool = true
var score = 0

func _ready():
	for noodle in noodles_root.get_children():
		noodle.connect("area_entered", self, "handleFry")
	
	for hit_point in hit_points.get_children():
		hit_point.connect("area_entered", self, "set_score", [hit_point])
#	drop_point.connect("area_entered", self, "enable drop")

func handleFry(body):
	pass

func set_score(area, hit_point):
	print(area)
	if hit_point.name == "SweetPoint":
		score += 5
	elif hit_point.name == "OkayPoint" || hit_point.name == "OkayPoint2":
		score += 1

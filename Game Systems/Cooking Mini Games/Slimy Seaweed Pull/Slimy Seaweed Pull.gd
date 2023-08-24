extends MiniGame

onready var wrap_root = get_node("Wraps")

var locations = {
	"NORTH":Vector2(120,-48),
	"SOUTH":Vector2(120,192),
	"EAST":Vector2(344,72),
	"WEST":Vector2(-104,72)
}

var wrap = preload("res://Game Systems/Cooking Mini Games/Slimy Seaweed Pull/Slimy Seaweed Wrap.tscn")
var rng = RandomNumberGenerator.new()

func _ready():
	wrap_root.connect("child_entered_tree", self, "connect_wrap_signal")
	create_wrap()
	
func create_wrap():
	rng.randomize()
	
	var direction = locations.keys()[rng.randi_range(0,locations.size()-1)]
	var wrap_instance = wrap.instance()
	wrap_instance.orientation = direction
	wrap_instance.position = locations[direction]
	wrap_root.add_child(wrap_instance)

func connect_wrap_signal(wrap):
	wrap.connect("wrap_placed", self, "create_wrap")

func _process(delta):
	if Input.is_action_just_pressed("ui_down"):
		create_wrap()

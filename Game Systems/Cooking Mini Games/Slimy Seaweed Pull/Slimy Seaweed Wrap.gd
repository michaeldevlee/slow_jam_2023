extends Sprite

onready var interact_area = get_node("Selectable")

var side_wrap = true
var orientation = "NORTH"

export var top_down_texture : Texture
export var left_right_texture : Texture

signal wrap_placed

func _ready():
	match orientation:
		"NORTH":
			texture = top_down_texture
		"SOUTH":
			texture = top_down_texture
			flip_v = true
		"EAST":
			texture = left_right_texture
			flip_h = true
		"WEST":
			texture = left_right_texture
	
	interact_area.orientation = orientation
	



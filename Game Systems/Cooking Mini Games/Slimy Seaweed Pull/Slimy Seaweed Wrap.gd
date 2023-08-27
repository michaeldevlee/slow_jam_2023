extends Sprite

onready var interact_area = get_node("Selectable")
onready var wrap_hit_point = get_node("WrapHitPoint")
onready var hit_point_col_box : CollisionShape2D = get_node("WrapHitPoint/CollisionShape2D")

var side_wrap = true
var orientation = "SOUTH"
var properly_wrapped = false

export var top_down_texture : Texture
export var left_right_texture : Texture

signal wrap_placed

func _ready():
	wrap_hit_point.connect("area_entered", self, "checkIfProperlyWrapped")
	match orientation:
		"NORTH":
			texture = top_down_texture
			hit_point_col_box.shape.extents = Vector2(128, 28)			
		"SOUTH":
			texture = top_down_texture
			flip_v = true
			hit_point_col_box.shape.extents = Vector2(128, 28)
		"EAST":
			texture = left_right_texture
			flip_h = true
			hit_point_col_box.shape.extents = Vector2(49, 72)
		"WEST":
			texture = left_right_texture
			hit_point_col_box.shape.extents = Vector2(49, 72)
			
	
	interact_area.orientation = orientation

func checkIfProperlyWrapped(area : Area2D):
	if area.is_in_group("FoodPile"):
		properly_wrapped = true



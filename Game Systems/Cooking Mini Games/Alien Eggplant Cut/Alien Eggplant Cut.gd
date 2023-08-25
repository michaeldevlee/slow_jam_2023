extends MiniGame

onready var circle = get_node("Area2D/CollisionShape2D")
onready var circle_sprite = get_node("Area2D/Sprite3")
var drawing : bool = false
var original_mos_pos = Vector2()
var original_collision_radius

func _ready():
	original_collision_radius = circle.shape.radius

func _unhandled_input(event):
	if Input.is_action_just_pressed("mouse_interact"):
		drawing = true
		circle.disabled = false
		circle.shape.radius = 1
		circle_sprite.scale = Vector2(1,1)
		circle_sprite.global_position = get_global_mouse_position()
		circle.global_position = get_global_mouse_position()
		original_mos_pos = get_global_mouse_position()
		Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	elif Input.is_action_just_released("mouse_interact"):
		drawing = false
		circle.disabled = true
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		
		
	
	if event is InputEventMouseMotion:
		if drawing:
			print(event.speed)
			circle.shape.radius += 2
			
			var target_scale = circle.shape.radius / original_collision_radius
			
			circle_sprite.scale = Vector2(target_scale,target_scale)

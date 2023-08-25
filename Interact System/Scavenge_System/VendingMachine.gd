extends Selectable

export var ingredient_in_machine : Resource
onready var anim_player = get_node("AnimationPlayer")
var click_count : int = 0
export var max_click_count : int = 2

func interact():
	if ingredient_in_machine:
		click_count += 1
		anim_player.play("Shake")
		if click_count >= max_click_count:
			Inventory.add(ingredient_in_machine)
			queue_free()
	
func _ready():
	pass # Replace with function body.


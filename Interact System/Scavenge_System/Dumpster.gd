extends Selectable

export var ingredient_in_machine : Resource

onready var anim_player = get_node("AnimationPlayer")
onready var sprite = get_node("Sprite")

var click_count : int = 0
export var multiplier = 1
export var max_click_count : int = 2

var sprite_regions = [0 , 32]

var rng = RandomNumberGenerator.new()

func interact():
	if ingredient_in_machine:
		click_count += 1
		anim_player.play("Shake")
		AudioEngine.playSFX(AudioEngine.digging_trash, -15)
		if click_count >= max_click_count:
			for i in multiplier:
				Inventory.add(ingredient_in_machine)
			queue_free()
	
func _ready():
	rng.randomize()
	
	var rand_int = rng.randi_range(0,1)
	sprite.set_region_rect(Rect2(sprite_regions[rand_int], 0, 32, 64))

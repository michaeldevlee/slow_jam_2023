extends Selectable

export var ingredient_in_machine : Resource

onready var anim_player = get_node("AnimationPlayer")
onready var sprite = get_node("Sprite")
onready var pop_up_sprite = get_node("Sprite2")
onready var collider = get_node("CollisionShape2D")

var click_count : int = 0
export var max_click_count : int = 2

var sprite_regions = [0 , 32]

var rng = RandomNumberGenerator.new()

func interact():
	if ingredient_in_machine:
		click_count += 1
		anim_player.play("Shake")
		AudioEngine.playSFX(AudioEngine.digging_trash, -15)
		if click_count >= max_click_count:
			collider.disabled = true
			Inventory.add(ingredient_in_machine)
			anim_player.play("show_ingredient")
			yield(anim_player, "animation_finished")
			queue_free()
	
func _ready():
	rng.randomize()
	
	var rand_int = rng.randi_range(0,1)
	sprite.set_region_rect(Rect2(sprite_regions[rand_int], 0, 32, 64))
	if ingredient_in_machine:
		pop_up_sprite.texture = ingredient_in_machine.icon

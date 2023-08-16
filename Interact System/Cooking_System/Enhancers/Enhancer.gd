extends Control
class_name Enhancer

export var enhancer : Resource
var activated : bool = false
onready var menu = get_node("Menu")
onready var button = get_node("Enhancer_Toggle_Button")

var enhance_slot = preload("res://Game Systems/Enhance_Slot.tscn")

func _ready():
	button.connect("button_up", self, "toggle")
	
	print(GameState.available_enhancers.size())
	
	for enhancer in GameState.available_enhancers.size():
		var new_slot : TextureButton = enhance_slot.instance()
		new_slot.connect("button_up", self, "selected", [new_slot])
		menu.add_child(new_slot)

	
func toggle():
	if Inventory.inventory.has(enhancer.name):
		if !activated:
			set_modulate(Color(1,1,1,1))
		else:
			set_modulate(Color(1,1,1,0.3))
		
		activated = !activated
	
	if activated:
		updateSlots()
		menu_open(true)
	else:
		menu_open(false)
		

func selected (slot):
	print(slot)

func updateSlots():
	var i = 0
	
	for enhancer in GameState.unlocked_enhancers:
		if enhancer:
			menu.get_child(i).texture_normal = enhancer.icon
			print(menu.get_child(i))
		i += 1


func menu_open(status : bool):
	menu.visible = status


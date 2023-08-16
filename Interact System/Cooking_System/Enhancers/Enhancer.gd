extends Control

var selected_enhancer

var activated : bool = false
onready var menu = get_node("Menu")
onready var button = get_node("Enhancer_Toggle_Button")

var enhance_slot = preload("res://Game Systems/Enhance_Slot.tscn")

func _ready():
	button.connect("button_up", self, "toggle")
	
	print(GameState.available_enhancers.size())
	
	for enhancer in GameState.available_enhancers:
		var new_slot : TextureButton = enhance_slot.instance()
		new_slot.connect("button_up", self, "selected", [new_slot])
		new_slot.enhancer = enhancer
		menu.add_child(new_slot)
	
func deselect():
	for enhancer_slot in menu.get_children():
		if enhancer_slot:
			enhancer_slot.selected = false
	selected_enhancer = null
	
func toggle():
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
		deselect()
		

func selected (slot):
	var enhancer_resource = slot.enhancer
	
	deselect()
	
	selected_enhancer = enhancer_resource
	slot.selected = true

func updateSlots():
	var i = 0
	
	for enhancer in GameState.available_enhancers:
		if enhancer and GameState.unlocked_enhancers.has(enhancer):
			menu.get_child(i).texture_normal = enhancer.icon
		elif enhancer:
			menu.get_child(i).texture_normal = enhancer.icon
			menu.get_child(i).set_modulate(Color(1,1,1,0.3))
		i += 1
			
func cleanup():
	deselect()

func menu_open(status : bool):
	menu.visible = status


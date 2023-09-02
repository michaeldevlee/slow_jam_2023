extends CanvasLayer

onready var anim_player = get_node("AnimationPlayer")
onready var inv_container = get_node("Inventory_Container")

export var close_button_path : NodePath
var close_button
var inventory_slots
var current_item_map = {}
var current_empty_index = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	Inventory.connect("added_ingredient", self, "updateSlots")
	Inventory.connect("removed_ingredient", self, "updateSlots")
	
	inv_container.visible = false
	if close_button_path:
		close_button = get_node(close_button_path)
		close_button.connect("button_up", self, "close")
	
	inventory_slots = get_tree().get_nodes_in_group("Inventory_Slot")
	
	for slot in inventory_slots:
		slot.connect("button_up", self, "test", [slot])
		

func checkIfItemAlreadyInInventory(item) -> bool :
	if current_item_map.has(item):
		return true
	else:
		return false

func addSlotForItem(item):
	var slot = inventory_slots[current_empty_index]
	
	current_item_map[item] = current_empty_index
	
	slot.item = item
	slot.quantity = Inventory.inventory[item]
	slot.item_picture.texture = item.icon
	slot.quantity_label.visible = true
	current_empty_index += 1
	print('added a slot')

func updateSlotForItem(item):
	var index = current_item_map[item]
	var slot = inventory_slots[index]
	
	slot.quantity = Inventory.inventory[item]
	print("updated a slot")

func updateSlots(item):
	var hasItem = checkIfItemAlreadyInInventory(item)
	
	if !hasItem:
		addSlotForItem(item)
	else:
		updateSlotForItem(item)
	

func play_open_inv():
	AudioEngine.playSFX(AudioEngine.open_inv)
	
func play_close_inv():
	AudioEngine.playSFX(AudioEngine.close_inv)
		

func clear_slots():
	for slot in inventory_slots:
		slot.item = null
		slot.quantity = 0
		slot.quantity_label.visible = false

func close():
	anim_player.play("Close_Inv")
	get_tree().call_group("Inventory_Slot", "clear_slots")
	AudioEngine.playSFX(AudioEngine.close_inv)


func _process(delta):
	if Input.is_action_just_pressed("inventory") and !GameState.tutorial_mode:
		if inv_container.visible:
			anim_player.play("Close_Inv")
		else:
			anim_player.play("Open_Inv")

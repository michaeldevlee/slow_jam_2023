extends CanvasLayer

export var close_button_path : NodePath
var close_button
var inventory_slots
var current_index = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	if close_button_path:
		close_button = get_node(close_button_path)
		close_button.connect("button_up", self, "close")
	
	inventory_slots = get_tree().get_nodes_in_group("Inventory_Slot")
	
	for slot in inventory_slots:
		slot.connect("button_up", self, "test", [slot])
		
	updateSlots()

func updateSlots():
	var item_keys = Inventory.inventory.keys()
	for slot in inventory_slots:
		
		if item_keys.size() == 0:
			break
			
		if slot.item == null:
			var selected_item = item_keys.back()
			
			if selected_item:
				slot.item = selected_item
				slot.quantity = Inventory.inventory[selected_item]
				slot.item_picture.texture = selected_item.icon
				slot.quantity_label.visible = true
	
		if slot.item == item_keys.back():
			slot.quantity = Inventory.inventory[item_keys.back()]
			slot.update_quantity()
		
		item_keys.pop_back()

			
	print(item_keys)


func clear_slots():
	for slot in inventory_slots:
		slot.item = null
		slot.quantity = 0
		slot.quantity_label.visible = false

func close():
	visible = false
	get_tree().call_group("Inventory_Slot", "clear_slots")


func _process(delta):
	if Input.is_action_just_pressed("inventory"):
		visible = !visible
		updateSlots()

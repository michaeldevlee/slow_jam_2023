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
		if slot.item == null:
			var selected_item = item_keys.pop_back()
			
			if selected_item:
				slot.item = selected_item
				slot.quantity = Inventory.inventory[selected_item]
				slot.item_picture.texture = selected_item.icon
	print(item_keys)
	
	

func test(slot):
	print(slot.item.name)
	print(slot.quantity)
	
	

func close():
	print('close UI')

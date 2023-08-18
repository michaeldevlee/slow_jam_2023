extends TextureButton

onready var quantity = get_node("Label")
var ingredient
var modal_inv = 0

func _ready():
	connect("button_up", self, "increase")

func increase():
	if Inventory.inventory.has(ingredient):
		var player_inv = Inventory.inventory[ingredient]
		print('increase')
		
		if player_inv > modal_inv:
			modal_inv += 1
			quantity.set_text(str(modal_inv))
	
func decrease():
	print('decreasing')

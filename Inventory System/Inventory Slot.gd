extends TextureButton

onready var item_picture = get_node("TextureRect")
onready var quantity_label =get_node("TextureRect/Label")

var item
var quantity setget update_quantity

func update_quantity(value):
	quantity = value
	quantity_label.set_text(str(quantity))

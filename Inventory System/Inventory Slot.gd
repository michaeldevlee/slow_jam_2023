extends TextureButton

onready var item_picture = get_node("TextureRect")
onready var quantity_label =get_node("TextureRect/Label")

var item
var quantity

func update_quantity():
	quantity_label.set_text(str(quantity))

extends TextureRect

onready var label = get_node("Label")
export (String, "RECIPE", "INGREDIENT", "QUANTIFIER") var type

func _ready():
	match type:
		"RECIPE":
			label.queue_free()
		"INGREDIENT":
			label.queue_free()
		"QUANTIFIER":
			set_quantity(0)

func set_quantity(quantity : int):
	label.set_text("x" + str(quantity))

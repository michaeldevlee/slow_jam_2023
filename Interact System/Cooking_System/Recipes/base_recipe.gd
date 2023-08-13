extends Selectable

export (String, "Recipe_Name") var recipe

onready var title = get_node("Control/ColorRect/Label")
onready var menu = get_node("Control")

func _ready():
	title.set_text(recipe)

func interact():
	menu.visible = !menu.visible

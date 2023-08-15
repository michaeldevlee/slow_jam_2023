extends Selectable

func interact():
	if get_parent() and get_parent() is Recipe:
		get_parent().emit_signal("recipe_selected", get_parent())

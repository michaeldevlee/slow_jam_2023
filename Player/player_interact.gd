extends Selectable

func interact():
	InteractEventBus.emit_signal("selected", get_parent())

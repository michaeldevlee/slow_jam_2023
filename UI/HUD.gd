extends CanvasLayer

onready var skip_button = get_node("TextureButton")
onready var pop_up = get_node("VBoxContainer")
onready var text = get_node("VBoxContainer/HBoxContainer/TextureRect/HBoxContainer/VBoxContainer/Label")
onready var texture = get_node("VBoxContainer/HBoxContainer/TextureRect/HBoxContainer/VBoxContainer/TextureRect")
onready var close_button = get_node("VBoxContainer/HBoxContainer/TextureRect/HBoxContainer/VBoxContainer/CloseButton")
onready var anim_player = get_node("AnimationPlayer")
onready var money_display = get_node("Label")

# Called when the node enters the scene tree for the first time.
func _ready():
	skip_button.connect("button_up", self, "skip_current_state")
	close_button.connect("button_up", self, "close")
	InteractEventBus.connect("pop_up_event_started", self, "pop_up")
	InteractEventBus.connect("mini_game_ended", self, "update_money")


func skip_current_state():
	InteractEventBus.emit_signal("skip_initiated")

func pop_up(event):
	get_tree().paused = true
	anim_player.play("Open")
	text.set_text(event.message)
	if event.ingredient:
		texture.texture = event.ingredient.icon
	pop_up.visible = true

func update_money(finished_recipe : Recipe):
	money_display.set_text(str(Inventory.money))

func close():
	anim_player.play("Close")
	texture.texture = null
	get_tree().paused = false
	

extends CanvasLayer

onready var anim_player = get_node("AnimationPlayer")
onready var text = get_node("TextureRect/Label2")
onready var char_name = get_node("TextureRect/Label")

signal dialogue_started
signal dialogue_finished (next_event)

var messages = ["hello", "from", "gdscript"]
var event 
var index = 0

func _ready():
	visible = false

func init(char_name: String, dialogue_text : Array, event):
	self.char_name.set_text(char_name)
	emit_signal("dialogue_started")
	open_dialogue()
	load_messages(dialogue_text)
	load_event(event)
	display_message()
	print('loaded message')
	print(dialogue_text)

func load_event(event):
	self.event = event

func load_messages(dialogue_text : Array):
	messages = dialogue_text

func close_dialogue():
	visible = false

func open_dialogue():
	visible = true

func display_message():
	if index > messages.size()-1:
		emit_signal("dialogue_finished", event)
		cleanup()
		return
	text.percent_visible = 0
	text.set_text(messages[index])		
	anim_player.play("display_text")
	index += 1

func clear_messages():
	messages = []

func clear_event():
	event = null

func cleanup():
	clear_messages()
	close_dialogue()
	clear_event()
	index = 0

func _process(delta):
	if Input.is_action_just_pressed("mouse_interact") and visible:
		display_message()

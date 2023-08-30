extends CanvasLayer

onready var start_button = get_node("Control/Start_Button")
onready var anim_player = get_node("AnimationPlayer")
var main_game = preload("res://main.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	AudioEngine.playBG(AudioEngine.start_menu_music)
	start_button.connect("button_up", self, "start_game")
	

func start_game():
	anim_player.play("fade_out")
	yield(anim_player,"animation_finished")
	get_tree().change_scene_to(main_game)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

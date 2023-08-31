extends CanvasLayer

onready var start_button = get_node("Control/Start_Button")
onready var anim_player = get_node("AnimationPlayer")
var main_game = preload("res://main.tscn")

func _ready():
	yield(get_tree().create_timer(2), "timeout")
	AudioEngine.playBG(AudioEngine.start_menu_music)
	start_button.connect("button_up", self, "start_game")
	
func reveal_title_screen():
	anim_player.play("reveal_title")


func start_game():
	anim_player.play("fade_out")
	yield(anim_player,"animation_finished")
	get_tree().change_scene_to(main_game)

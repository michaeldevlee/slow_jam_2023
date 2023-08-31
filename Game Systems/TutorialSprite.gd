extends Sprite

onready var anim_player = get_node("AnimationPlayer")

func play_run_down():
	anim_player.play("Run_Down")

func play_idle():
	anim_player.play("RESET")

func play_run_side():
	anim_player.play("Run_Side")

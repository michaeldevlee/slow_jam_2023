extends CanvasLayer

func _ready():
	show()

func show():
	get_tree().paused = true
	visible = true
	AudioEngine.playBG(AudioEngine.ending_music)
	

extends MiniGame

onready var timer = get_node("Timer")
var growth_rate = 1

var basic_size_req = 1
var med_size_req = 0.5
var high_size_req = 0.2

var enhancer
# 1 = basic, 2 = med, 3 = high
var score_arr = []

func _ready():
	timer.connect("timeout", self, "end_mini_game")
	
	for button in get_children():
		if button is TextureButton:
			button.connect("button_up", self, "shrink", [button])

func addScore(score : float):
	if score < high_size_req:
		score_arr.append(3)
	elif score < med_size_req:
		score_arr.append(2)
	else:
		score_arr.append(1)
	

func checkScores(scores : Array):
	var lowest = scores[0]
	var highest = scores[0]
	for score in scores:
		lowest = min(score, lowest)
		highest = max(score, highest)
	print('lowest this: ' + str(lowest))
	match lowest:
		3:
			set_reward_type("big")
		2:
			set_reward_type("med")
		1:
			set_reward_type("basic")
				
				

func end_mini_game():
	set_process(false)
	for button in get_children():
		if button is TextureButton:
			addScore(button.rect_scale.x)
			button.disabled = true
			
	checkScores(score_arr)
	recipe.order.enhancers.clear()
	enhancer = null
	notify_mini_game_ended()

func shrink(button):
	button.rect_scale -= Vector2(0.5, 0.5)
	AudioEngine.playSFX(AudioEngine.shrink)

func _process(delta):
	$Meatball.rect_scale += Vector2(growth_rate,growth_rate) * delta
	$Meatball2.rect_scale += Vector2(growth_rate,growth_rate) * delta
	$Meatball3.rect_scale += Vector2(growth_rate,growth_rate) * delta

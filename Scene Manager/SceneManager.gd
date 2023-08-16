extends Node2D

onready var cookingSystem = get_node("CookingSystem")
onready var scavengeSystem = get_node("ScavengeSystem")
onready var animPlayer = get_node("AnimationPlayer")


var curr_scene : Node2D 
var next_scene : Node2D
var needsInterupt : bool = false 

func next():
	if (!needsInterupt):
		animPlayer.play("fade")
		
		yield(animPlayer,"animation_finished")
		animPlayer.play("fade_out")

func toggle_scenes():
	curr_scene.visible = !curr_scene.visible
	next_scene.visible = !next_scene.visible

func _ready():
	cookingSystem.connect("visibility_changed", self, "getScene", [cookingSystem])
	scavengeSystem.connect("visibility_changed", self, "getScene", [scavengeSystem])
	
	var scenes = [cookingSystem, scavengeSystem]
	
	curr_scene = cookingSystem
	next_scene = scavengeSystem
	
	for scene in scenes:
		scene.visible = false
	
	scenes[0].visible = true

func getScene(scene):
	if cookingSystem.visible == true:
		scavengeSystem.cleanup()
		cookingSystem._init()
	else:
		scavengeSystem.init()
		cookingSystem.cleanup()
	

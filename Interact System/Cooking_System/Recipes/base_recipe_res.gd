extends Resource
class_name Recipe_Order

export var required_ingredients = []
export var upgrade_combo = {}
export var enhancers = []

export var name : String
export var icon : Texture
export var mini_icon : Texture

export var mini_game : PackedScene

export var basic_reward : int
export var med_reward : int
export var big_reward : int

var reward_type
var reward : int 

var submitted_ingredient_count : int = 0

func set_reward_type(type):
	var multiplier = submitted_ingredient_count / required_ingredients.size()
	
	reward_type = type
	match type:
		"basic":
			reward = basic_reward * multiplier
		"medium":
			reward = med_reward * multiplier
		"big":
			reward = big_reward * multiplier



# indexes
#	"SCRAPHEAD NOODLE"  : 0
#	"RUSTY MEATBALL" : 1
#	"SLIMY SEAWEED WRAP" : 2
#	"QUANTUM BATTER" : 3
#	"ROTTEN METEOR MARINARA" : 4
#	"ALIENT EGGPLANT" : 5
#]

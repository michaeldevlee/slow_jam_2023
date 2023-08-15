extends Resource
class_name Recipe_Order

export var required_ingredients = []
export var upgrade_combo = {}

export var name : String
export var icon : Texture

export var mini_game : PackedScene

export var basic_reward : int
export var med_reward : int
export var big_reward : int

# indexes
#	"SCRAPHEAD NOODLE"  : 0
#	"RUSTY MEATBALL" : 1
#	"SLIMY SEAWEED WRAP" : 2
#	"QUANTUM BATTER" : 3
#	"ROTTEN METEOR MARINARA" : 4
#	"ALIENT EGGPLANT" : 5
#]

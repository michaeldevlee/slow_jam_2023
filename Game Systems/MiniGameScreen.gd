extends Control
class_name MiniGameScreen

signal mini_game_ended

onready var mini_game_container = get_node("MiniGameContainer")

func start(curr_recipe : Recipe):
	var mini_game : MiniGame = curr_recipe.order.mini_game.instance()
	mini_game_container.add_child(mini_game)
	mini_game.recipe = curr_recipe

		
		


extends Node2D

@export var mining_minigame: MiningMinigame
@export var end_game_screen: Control


func _on_button_pressed():
	end_game_screen.hide()
	mining_minigame.new_game()

func _on_mining_minigame_game_over():
	end_game_screen.show()

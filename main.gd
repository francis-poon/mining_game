extends Node2D

@export var mining_minigame: MiningMinigame

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	mining_minigame.hide()


func _on_mining_tile_activated() -> void:
	mining_minigame.new_game()
	mining_minigame.show()


func _on_game_over() -> void:
	mining_minigame.hide()

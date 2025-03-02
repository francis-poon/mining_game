class_name MiningMinigame
extends Control

signal game_over(item_drops: InventoryData)

@export var mining_durability_bar: ProgressBar
@export var mining_surface: MiningSurface
@export var mining_tool_selector: MiningToolSelector

func _ready():
	new_game()

func new_game():
	mining_durability_bar.new_game()
	mining_surface.new_game()
	mining_tool_selector.new_game()

func end_game():
	var item_drops: InventoryData = mining_surface.end_game()
	game_over.emit(item_drops)

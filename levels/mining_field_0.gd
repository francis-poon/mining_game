extends Level

@export var mining_minigame: MiningMinigame
@export var mining_spot_manager: MiningSpotManager

func _ready() -> void:
	super._ready()
	mining_minigame.hide()

func _on_mining_tile_activated() -> void:
	mining_minigame.new_game()
	mining_minigame.show()


func _on_game_over(item_drops: InventoryData) -> void:
	mining_minigame.hide()
	mining_spot_manager.delete_active_mining_spot()
	inventory_change.emit(item_drops)

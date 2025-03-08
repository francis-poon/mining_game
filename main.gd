extends Node2D

@export var mining_minigame: MiningMinigame
@export var item_manager: ItemManager
@export var inventory: PlayerInventory
@export var mining_spot_manager: MiningSpotManager

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	mining_minigame.hide()
	get_class()
	Logger.trace("Item Name: {0}".format([item_manager.get_item(0).item_name]))

#func _draw() -> void:
	#await get_tree().process_frame
	#Logger.trace(item_manager.get_item(0).name)


func _on_mining_tile_activated() -> void:
	mining_minigame.new_game()
	mining_minigame.show()


func _on_game_over(item_drops: InventoryData) -> void:
	mining_minigame.hide()
	inventory.add_items(item_drops)
	mining_spot_manager.delete_active_mining_spot()

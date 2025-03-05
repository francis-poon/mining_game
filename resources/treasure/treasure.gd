class_name Treasure
extends Resource

@export var item_drops: InventoryData
@export var pattern_id: int

func _init(p_item_drops: InventoryData = InventoryData.new(), p_pattern_id: int = 0):
	item_drops = p_item_drops
	pattern_id = p_pattern_id

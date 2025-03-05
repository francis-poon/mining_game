class_name InventoryData
extends Resource

@export var item_count: Dictionary

func _init(p_item_count = {}):
	item_count = p_item_count

func add_inventory(items: InventoryData):
	for item in items.item_count:
		if item in item_count:
			item_count[item] += items.item_count[item]
		else:
			item_count[item] = items.item_count[item]

func add_dictionary(items: Dictionary):
	for item in items:
		if item in item_count:
			item_count[item] += items[item]
		else:
			item_count[item] = items[item]

class_name PlayerInventory
extends Node

signal inventory_changed(inventory_data: InventoryData)

var inventory_data: InventoryData = InventoryData.new({})
var _save_file_name: String = "inventory.tres"

func add_item(item_id: int, count: int):
	if inventory_data.item_count.has(item_id):
		inventory_data.item_count[item_id] += count
	else:
		inventory_data.item_count[item_id] = count
	inventory_changed.emit(inventory_data)

func add_items(items: InventoryData):
	for item_id in items.item_count:
		if item_id in inventory_data.item_count:
			inventory_data.item_count[item_id] += items.item_count[item_id]
		else:
			inventory_data.item_count[item_id] = items.item_count[item_id]
	inventory_changed.emit(inventory_data)

func remove_item(item_id: int, count: int) -> bool:
	if not inventory_data.item_count.has(item_id) or inventory_data.item_count[item_id] < count:
		return false
	
	inventory_data.item_count[item_id] -= count
	if inventory_data.item_count[item_id] <= 0:
		inventory_data.item_count.erase(item_id)
	
	inventory_changed.emit(inventory_data)
	return true

func get_item_count(item_id: int) -> int:
	if inventory_data.item_count.has(item_id):
		return inventory_data.item_count[item_id]
	return 0

func save_data(save_dir: String):
	var result = ResourceSaver.save(inventory_data, save_dir + _save_file_name)
	if result != OK:
		print(result)

func load_data(save_dir: String):
	inventory_data = ResourceLoader.load(save_dir + _save_file_name)
	if not inventory_data or inventory_data is not InventoryData:
		inventory_data = InventoryData.new({})
	inventory_changed.emit(inventory_data)

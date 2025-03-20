class_name ItemManager
extends Node

var item_dictionary: Dictionary = {}

func _ready() -> void:
	for child in get_children():
		if child is ItemData:
			item_dictionary[child.id] = child

func get_item(id: int):
	if not item_dictionary.has(id):
		Logger.error("Attempted to get non-existent item id: {0}".format([id]))
		return null
	return item_dictionary[id]

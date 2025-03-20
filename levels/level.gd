class_name Level
extends Node2D

signal teleport(destination_level_name: String, destination_teleport_name: String)
signal inventory_change(item_data: InventoryData)

@export var default_teleport: Node2D
@export var _default_spawn_point: Node2D

@export var _teleport_points: Node


func _ready() -> void:
	for child in _teleport_points.get_children():
		child.teleport.connect(_on_teleport)

func get_teleport_point_pos(p_teleport_name: String) -> Vector2:
	for child in _teleport_points.get_children():
		if child.teleport_name == p_teleport_name:
			return child.position
	return default_teleport.position

func pause_teleport(p_teleport_name):
	for child in _teleport_points.get_children():
		if child.teleport_name == p_teleport_name:
			child.pause_teleport()

func unpause_other_teleports(p_teleport_name):
	for child in _teleport_points.get_children():
		if child.teleport_name != p_teleport_name:
			child.unpause_teleport()

func pause_all_teleports():
	for child in _teleport_points.get_children():
		child.pause_teleport()

func unpause_all_teleports():
	for child in _teleport_points.get_children():
		child.unpause_teleport()

func get_default_spawn_point() -> Vector2:
	return _default_spawn_point.position

func _on_teleport(destination_level_name: String, destination_teleport_name: String):
	teleport.emit(destination_level_name, destination_teleport_name)

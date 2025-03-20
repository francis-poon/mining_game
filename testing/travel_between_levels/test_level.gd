class_name TestLevel
extends Node2D

signal teleport(destination_level_name: String, destination_teleport_name: String)

@export var default_teleport: Node2D

@export var _teleport_points: Node


func _ready() -> void:
	for child in _teleport_points.get_children():
		child.teleport.connect(_on_teleport)

func get_teleport_point_pos(p_teleport_name: String) -> Vector2:
	var teleport_point: Vector2 = default_teleport.position
	for child in _teleport_points.get_children():
		if child.teleport_name == p_teleport_name:
			teleport_point = child.position
		else:
			child.unpause_teleport()
	return teleport_point

func pause_teleport(p_teleport_name):
	for child in _teleport_points.get_children():
		if child.teleport_name == p_teleport_name:
			child.pause_teleport()

func pause_all_teleports():
	for child in _teleport_points.get_children():
		child.pause_teleport()

func unpause_all_teleports():
	for child in _teleport_points.get_children():
		child.unpause_teleport()

func _on_teleport(destination_level_name: String, destination_teleport_name: String):
	teleport.emit(destination_level_name, destination_teleport_name)

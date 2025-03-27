class_name TestTeleportPoint
extends Area2D

signal teleport(destination_level_name: String, destination_teleport_name: String)

@export var destination_level_name: String
@export var destination_teleport_name: String
@export var teleport_name: String
var _can_teleport: bool

func _enter_tree() -> void:
	_can_teleport = false

func _on_body_exited(body: Node2D) -> void:
	if body is Player:
		_can_teleport = true

func _on_body_entered(body: Node2D) -> void:
	if body is Player and _can_teleport:
		teleport.emit(destination_level_name, destination_teleport_name)

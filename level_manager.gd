class_name LevelManager
extends Node

signal teleport_player(pos: Vector2)
signal inventory_change(item_data: InventoryData)
signal level_ready

@export var levels: Dictionary = {}

@export var starting_level: String = "main_town"

var current_level_name: String
var current_level: Level
var _current_spawn_point: String

func _ready() -> void:
	current_level_name = starting_level
	current_level = levels[current_level_name].instantiate()
	current_level.teleport.connect(_on_teleport)
	current_level.inventory_change.connect(_on_inventory_change)
	level_ready.emit()
	

func _on_teleport(map: String, spawn_point: String):
	Logger.trace("Currently in {0}, attemping to teleport to map {1} point {2}".format([current_level_name, map, spawn_point]))
	if current_level_name != map:
		current_level.pause_all_teleports()
		current_level.queue_free()
		current_level_name = map
		current_level = levels[current_level_name].instantiate()
		current_level.teleport.connect(_on_teleport)
		current_level.inventory_change.connect(_on_inventory_change)
	_current_spawn_point = spawn_point
	teleport_player.emit(current_level.get_teleport_point_pos(spawn_point))

func unpause_teleports():
	if get_children().size() == 0:
		call_deferred("add_child", current_level)
	current_level.unpause_other_teleports(_current_spawn_point)

func on_codex_changed(codex_data: CodexData):
	if current_level.has_method("on_codex_changed"):
		current_level.on_codex_changed(codex_data)

func on_main_ready():
	current_level.unpause_all_teleports()
	add_child(current_level)

func _on_inventory_change(item_data: InventoryData):
	inventory_change.emit(item_data)

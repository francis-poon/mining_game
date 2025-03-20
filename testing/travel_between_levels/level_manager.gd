extends Node

@export var level_a: PackedScene
@export var level_b: PackedScene
@export var level_c: PackedScene
@export var player: Player

@export var starting_level: String = "level_a"

var current_level_name: String
var current_level: TestLevel
var levels: Dictionary

func _ready() -> void:
	levels = {}
	levels["level_a"] = level_a
	levels["level_b"] = level_b
	levels["level_c"] = level_c
	current_level_name = starting_level
	current_level = levels[current_level_name].instantiate()
	current_level.teleport.connect(_on_teleport)
	current_level.unpause_all_teleports()
	add_child(current_level)

func _on_teleport(map: String, spawn_point: String):
	if current_level_name != map:
		current_level.pause_all_teleports()
		get_child(0).queue_free()
		current_level_name = map
		current_level = levels[current_level_name].instantiate()
		current_level.teleport.connect(_on_teleport)
		player.position = current_level.get_teleport_point_pos(spawn_point)
		#current_level.pause_teleport(spawn_point)
		call_deferred("add_child", current_level)
	else:
	#current_level.pause_teleport(spawn_point)
	#current_level.pause_all_teleports()
		player.position = current_level.get_teleport_point_pos(spawn_point)
	#current_level.unpause_all_teleports()
	#current_level.pause_teleport(spawn_point)

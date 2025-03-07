extends Node2D

signal mining_tile_activated

@export var _spawn_point_map: TileMapLayer
@export var mining_tile_scene: PackedScene

# A 0 to 1 ratio of how many of the valid spawn points can be spawned
@export var _max_spawn_saturation: float

var _valid_spawn_points: Array[Vector2i]
var _spawned_points: Array[Vector2i]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_valid_spawn_points = _spawn_point_map.get_used_cells()
	_spawn_point_map.hide()
	if _valid_spawn_points.size() == 0:
		Logger.warn("{0}: No spawn points found".format([get_script().get_path()]))
	_saturate_spawns()

# Attemps to spawn a new mining spot at pos
# returns false if no new mining spot is spawned
# returns true if new mining spot is spawned
func _spawn_new_mining_spot(pos: Vector2i) -> bool:
	Logger.trace("{0}: Spawning new point".format([get_script().get_path()]))
	if pos in _spawned_points:
		return false
	_spawned_points.append(pos)
	
	var new_mining_spot: MiningTile = mining_tile_scene.instantiate()
	new_mining_spot.position = _spawn_point_map.map_to_local(pos)
	add_child(new_mining_spot)
	return true

func _saturate_spawns():
	var _is_spawn_saturated = func test():
		return _spawned_points.size() < int(_max_spawn_saturation * _valid_spawn_points.size())
	while _is_spawn_saturated.call():
		var new_spawn_point = _valid_spawn_points.pick_random()
		_spawn_new_mining_spot(new_spawn_point)

func _on_timer_timeout() -> void:
	_saturate_spawns()

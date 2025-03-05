class_name MiningSpotManager
extends Node2D

signal mining_tile_activated

@export var _spawn_point_map: TileMapLayer
@export var mining_tile_scene: PackedScene

# A 0 to 1 ratio of how many of the valid spawn points can be spawned
@export var _max_spawn_saturation: float

var _valid_spawn_points: Array[Vector2i]
var _spawned_points: Dictionary
var _active_mining_spot: Vector2i = Vector2i.MAX
#so what i need to do is spawn new mining spots and save them here. the mining spots have to be cleared
#i need to track the spawned points so that i can make sure there arne't repeating points, but i also need
#a reference to the mining spot into order to call queue free on it. Well actually no, i don't need to have
#a reference to every mining spot, just the one that was clicked on by the player. So maybe the signal
#for the mining spots will send a reference to themselves so that i can save it and call queue free on that
#reference. But then for the spawned points, how do i remove the mining spot that i just called queue free on?
# i think in that case its better to make the spawned points a dictionary, and have the mining spot signal
# send its position instead

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_valid_spawn_points = _spawn_point_map.get_used_cells()
	_spawn_point_map.hide()
	if _valid_spawn_points.size() == 0:
		Logger.warn("{0}: No spawn points found".format([get_script().get_path()]))
	_saturate_spawns()


func delete_active_mining_spot():
	if _active_mining_spot == Vector2i.MAX or _active_mining_spot not in _spawned_points:
		Logger.warn("{0}: Tried to delete active mining spot when there was none".format([get_script().get_path()]))
		return
	Logger.trace("{0}: Removing active mining spot {1}".format([get_script().get_path(), _active_mining_spot]))
	_spawned_points[_active_mining_spot].queue_free()
	_spawned_points.erase(_active_mining_spot)

# Attemps to spawn a new mining spot at pos
# returns false if no new mining spot is spawned
# returns true if new mining spot is spawned
func _spawn_new_mining_spot(pos: Vector2i) -> bool:
	Logger.trace("{0}: Spawning new point".format([get_script().get_path()]))
	if pos in _spawned_points:
		return false
	
	
	var new_mining_spot: MiningTile = mining_tile_scene.instantiate()
	new_mining_spot.grid_pos = pos
	new_mining_spot.position = _spawn_point_map.map_to_local(pos)
	new_mining_spot.mining_tile_activated.connect(_on_mining_tile_activated)
	
	_spawned_points[pos] = new_mining_spot
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

func _on_mining_tile_activated(pos: Vector2i):
	_active_mining_spot = pos
	mining_tile_activated.emit()

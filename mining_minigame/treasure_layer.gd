class_name TreasureTileMap
extends TileMapLayer

var MAX_SPAWN_ATTEMPTS: int = 5

@export var treasure_tile: Vector2i = Vector2i.ZERO
var map_target_rect: Rect2i = Rect2i(Vector2i(0, 0), Vector2i(1, 1))

func new_game(p_map_target_rect: Rect2i, p_treasure_spawn_count: int):
	for used_cell_coord in get_used_cells():
		erase_cell(used_cell_coord)
	
	map_target_rect = p_map_target_rect
	spawn_treasures(p_treasure_spawn_count)

func spawn_treasures(treasure_count: int):
	for i in range(treasure_count):
		_attempt_spawn()

func _attempt_spawn() -> bool:
	for i in range(MAX_SPAWN_ATTEMPTS):
		var spawn_point = Vector2i(randi_range(0, map_target_rect.size.x - 1), randi_range(0, map_target_rect.size.y - 1))
		if get_cell_tile_data(spawn_point):
			continue
		set_cell(spawn_point, tile_set.get_source_id(0), treasure_tile)
		return true
	return false

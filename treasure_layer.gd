class_name TreasureTileMap
extends TileMapLayer

var MAX_SPAWN_ATTEMPTS: int = 5

@export var treasure_tile: Vector2i = Vector2i.ZERO
var map_target_rect: Rect2i = Rect2i(Vector2i(0, 0), Vector2i(1, 1))

func spawn_treasures(treasure_count: int):
	for i in range(treasure_count):
		_attempt_spawn()

func _attempt_spawn() -> bool:
	for i in range(MAX_SPAWN_ATTEMPTS):
		var spawn_point = Vector2i(randi_range(0, map_target_rect.size.x), randi_range(0, map_target_rect.size.y))
		if get_cell_tile_data(spawn_point):
			continue
		set_cell(spawn_point, tile_set.get_source_id(0), treasure_tile)
		return true
	return false

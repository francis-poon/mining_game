class_name MiningTileMap
extends TileMapLayer

signal map_ready(global_target_rect: Rect2)

@export var mining_stage_tiles: Array[Vector2i] = [Vector2i(0, 0)]
@export var map_target_rect: Rect2i = Rect2i(Vector2i(0, 0), Vector2i(1, 1))

var mining_stage: Array[Array]
var MINING_SHAPE: Array[Vector2i] = [
	Vector2i(0, 0),
	Vector2i(1, 0),
	Vector2i(-1, 0),
	Vector2i(0, 1),
	Vector2i(0, -1)
]

func _ready() -> void:
	mining_stage = []
	mining_stage.resize(map_target_rect.size.x)
	for x_pos in map_target_rect.size.x:
		mining_stage[x_pos] = []
		mining_stage[x_pos].resize(map_target_rect.size.y)
		for y_pos in map_target_rect.size.y:
			set_cell(Vector2i(x_pos, y_pos), tile_set.get_source_id(0), mining_stage_tiles[0])
			mining_stage[x_pos][y_pos] = 0

func _draw():
	await get_tree().process_frame
	var global_target_rect: Rect2 = Rect2()
	global_target_rect.position = to_global(map_to_local(map_target_rect.position)) - (Vector2(tile_set.tile_size) / 2)
	global_target_rect.size = Vector2(map_target_rect.size * tile_set.tile_size)
	map_ready.emit(global_target_rect)

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.pressed:
			_mine(local_to_map(get_local_mouse_position()))

func _mine(map_pos: Vector2i):
	if not map_target_rect.has_point(map_pos):
		return
	
	var tile_set_coord: Vector2i
	var mining_pos: Vector2i
	for shape_offset in MINING_SHAPE:
		mining_pos = map_pos + shape_offset
		if _is_mineable(mining_pos):
			mining_stage[mining_pos.x][mining_pos.y] += 1
			if mining_stage[mining_pos.x][mining_pos.y] >= mining_stage_tiles.size():
				erase_cell(mining_pos)
			else:
				tile_set_coord = mining_stage_tiles[mining_stage[mining_pos.x][mining_pos.y]]
				set_cell(mining_pos, tile_set.get_source_id(0), tile_set_coord)

func _is_mineable(map_pos: Vector2i) -> bool:
	return map_target_rect.has_point(map_pos) and mining_stage[map_pos.x][map_pos.y] < mining_stage_tiles.size()

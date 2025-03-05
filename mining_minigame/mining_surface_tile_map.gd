class_name MiningSurfaceTileMap
extends TileMapLayer

signal map_ready(global_target_rect: Rect2)
signal mine(amount: float)

@export var mining_stage_tiles: Array[Vector2i] = [Vector2i(0, 0)]

var map_target_rect: Rect2i = Rect2i(Vector2i(0, 0), Vector2i(1, 1))
var mining_stage: Array[Array]
var mining_shape: Array[Vector2i] = [Vector2i.ZERO]

var _is_playing: bool
var _rand_noise: FastNoiseLite

func _ready():
	_rand_noise = FastNoiseLite.new()
	_rand_noise.noise_type = FastNoiseLite.TYPE_PERLIN
	_rand_noise.frequency = 0.016
	_rand_noise.fractal_type = FastNoiseLite.FRACTAL_PING_PONG
	_rand_noise.fractal_octaves = 2
	_rand_noise.fractal_lacunarity = 2.960
	_rand_noise.fractal_gain = 4.74
	_rand_noise.fractal_weighted_strength = 3.55
	_rand_noise.fractal_ping_pong_strength = 2

func new_game(p_map_target_rect: Rect2i):
	_rand_noise.seed = randi()
	for used_cell_coord in get_used_cells():
		erase_cell(used_cell_coord)
	
	map_target_rect = p_map_target_rect
	
	mining_stage = []
	mining_stage.resize(map_target_rect.size.x)
	for x_pos in map_target_rect.size.x:
		mining_stage[x_pos] = []
		mining_stage[x_pos].resize(map_target_rect.size.y)
		for y_pos in map_target_rect.size.y:
			var rand_tile_stage = clampf(_rand_noise.get_noise_2d(x_pos, y_pos), -1, 1)
			rand_tile_stage = int((rand_tile_stage + 1) * (mining_stage_tiles.size()-2) / 2)
			
			set_cell(Vector2i(x_pos, y_pos), tile_set.get_source_id(0), mining_stage_tiles[rand_tile_stage])
			mining_stage[x_pos][y_pos] = rand_tile_stage
	
	queue_redraw()
	_is_playing = true

func end_game():
	_is_playing = false

func _draw():
	await get_tree().process_frame
	var global_target_rect: Rect2 = Rect2()
	global_target_rect.position = to_global(map_to_local(map_target_rect.position)) - (Vector2(tile_set.tile_size) / 2)
	global_target_rect.size = Vector2(map_target_rect.size * tile_set.tile_size)
	map_ready.emit(global_target_rect)

func _input(event: InputEvent) -> void:
	if not _is_playing:
		return
	
	if event is InputEventMouseButton:
		if event.pressed:
			_mine(local_to_map(get_local_mouse_position()))

func _mine(map_pos: Vector2i):
	if not map_target_rect.has_point(map_pos):
		return
	
	var tile_set_coord: Vector2i
	var mining_pos: Vector2i
	for shape_offset in mining_shape:
		mining_pos = map_pos + shape_offset
		if _is_mineable(mining_pos):
			mining_stage[mining_pos.x][mining_pos.y] += 1
			if mining_stage[mining_pos.x][mining_pos.y] >= mining_stage_tiles.size():
				erase_cell(mining_pos)
			else:
				tile_set_coord = mining_stage_tiles[mining_stage[mining_pos.x][mining_pos.y]]
				set_cell(mining_pos, tile_set.get_source_id(0), tile_set_coord)
	mine.emit(mining_shape.size())

func _is_mineable(map_pos: Vector2i) -> bool:
	return map_target_rect.has_point(map_pos) and mining_stage[map_pos.x][map_pos.y] < mining_stage_tiles.size()

func set_mining_shape(shape: Array[Vector2i]):
	mining_shape = shape

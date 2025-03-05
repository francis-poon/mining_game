class_name TreasureTileMap
extends TileMapLayer

var MAX_SPAWN_ATTEMPTS: int = 5

@export var treasure_collection: TreasureCollection

var map_target_rect: Rect2i = Rect2i(Vector2i(0, 0), Vector2i(1, 1))
var spawned_treasures: Array[SpawnedTreasure]
var target_treasure_count: Array[int]

func _ready() -> void:
	tile_set = treasure_collection.tile_set

func new_game(p_map_target_rect: Rect2i, p_target_treasure_count: Array[int]):
	for used_cell_coord in get_used_cells():
		erase_cell(used_cell_coord)
	
	map_target_rect = p_map_target_rect
	target_treasure_count = p_target_treasure_count
	spawned_treasures = []
	_spawn_treasures()

func _spawn_treasures():
	for i in range(target_treasure_count[0]):
		_attempt_small_treasure_spawn()
	for i in range(target_treasure_count[1]):
		_attempt_medium_treasure_spawn()

func _attempt_small_treasure_spawn() -> bool:
	for i in range(MAX_SPAWN_ATTEMPTS):
		var spawn_point = Vector2i(randi_range(0, map_target_rect.size.x - 1), randi_range(0, map_target_rect.size.y - 1))
		if get_cell_tile_data(spawn_point):
			continue
		
		var rand_small_treasure: Treasure = treasure_collection.small_treasures.pick_random() as Treasure
		var spawned_rect = Rect2i(spawn_point, Vector2i(1,1))
		set_pattern(spawn_point, tile_set.get_pattern(rand_small_treasure.pattern_id))
		spawned_treasures.append(SpawnedTreasure.new(rand_small_treasure, spawned_rect))
		
		return true
	return false

func _attempt_medium_treasure_spawn() -> bool:
	var spawn_point = Vector2i(randi_range(0, map_target_rect.size.x - 1), randi_range(0, map_target_rect.size.y - 1))
	var rand_medium_treasure: Treasure = treasure_collection.medium_treasures.pick_random() as Treasure
	var new_spawn_rect = Rect2i(spawn_point, tile_set.get_pattern(rand_medium_treasure.pattern_id).get_size())
	
	for spawned_treasure: SpawnedTreasure in spawned_treasures:
		if new_spawn_rect.intersects(spawned_treasure.rect) or not map_target_rect.encloses(new_spawn_rect):
			return false
	
	spawned_treasures.append(SpawnedTreasure.new(rand_medium_treasure, new_spawn_rect))
	set_pattern(spawn_point, tile_set.get_pattern(rand_medium_treasure.pattern_id))
	return true

class SpawnedTreasure:
	extends Resource
	
	@export var treasure: Treasure
	@export var rect: Rect2i
	
	func _init(p_treasure: Treasure = Treasure.new(), p_rect = Rect2i()):
		treasure = p_treasure
		rect = p_rect

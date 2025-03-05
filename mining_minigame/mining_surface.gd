class_name MiningSurface
extends SubViewportContainer

signal mine(amount: float)

@export var map_target_rect: Rect2i = Rect2i(Vector2i.ZERO, Vector2i(1, 1))

@export var _camera: TargetScaleCamera
@export var _mining_surface_tile_map: MiningSurfaceTileMap
@export var _treasure_tile_map: TreasureTileMap
@export var _mining_background_tile_map: MiningBackgroundTileMap

var treasure_spawn_count: Array[int]  = [5, 3]
const TREASURE_ITEM_ID = 0

func new_game():
	_mining_surface_tile_map.new_game(map_target_rect)
	_treasure_tile_map.new_game(map_target_rect, treasure_spawn_count)
	_mining_background_tile_map.new_game(map_target_rect)

func end_game() -> InventoryData:
	_mining_surface_tile_map.end_game()
	
	return _count_treasures()

func _ready() -> void:
	_mining_surface_tile_map.map_ready.connect(_on_map_ready)

# Private funcs
func _count_treasures() -> InventoryData:
	var item_drops: InventoryData = InventoryData.new()
	for spawned_treasure: TreasureTileMap.SpawnedTreasure in _treasure_tile_map.spawned_treasures:
		if _is_treasure_uncovered(spawned_treasure):
			item_drops.add_inventory(spawned_treasure.treasure.item_drops)
	Logger.debug("Treasures mined: {0}".format([item_drops.item_count]))
	return item_drops

func _is_treasure_uncovered(treasure: TreasureTileMap.SpawnedTreasure):
	for treasure_cell in _treasure_tile_map.tile_set.get_pattern(treasure.treasure.pattern_id).get_used_cells():
		if _mining_surface_tile_map.get_cell_tile_data(treasure.rect.position + treasure_cell):
			return false
	return true

# Signal handlers
func _on_map_ready(target_rect: Rect2):
	_camera.target = target_rect


func _on_mine(amount: float) -> void:
	mine.emit(amount)


func _on_select_mining_shape(shape: Array[Vector2i]) -> void:
	_mining_surface_tile_map.set_mining_shape(shape)

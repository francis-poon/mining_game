class_name MiningSurface
extends SubViewportContainer

signal mine(amount: float)

@export var map_target_rect: Rect2i = Rect2i(Vector2i.ZERO, Vector2i(1, 1))

@export var _camera: TargetScaleCamera
@export var _mining_tile_map: MiningTileMap
@export var _treasure_tile_map: TreasureTileMap

var treasure_spawn_count: int  = 5


func new_game():
	_mining_tile_map.new_game(map_target_rect)
	_treasure_tile_map.new_game(map_target_rect, treasure_spawn_count)

func end_game():
	_mining_tile_map.end_game()
	
	var treasure_count: int = 0
	for treasure_pos in _treasure_tile_map.get_used_cells():
		if not _mining_tile_map.get_cell_tile_data(treasure_pos):
			treasure_count += 1
	Logger.debug("Treasures mined: {0}".format([treasure_count]))

func _ready() -> void:
	_mining_tile_map.map_ready.connect(_on_map_ready)

func _on_map_ready(target_rect: Rect2):
	_camera.target = target_rect



#func _draw():
	#await get_tree().process_frame
	#_camera.scale_camera()

func _on_mine(amount: float) -> void:
	mine.emit(amount)


func _on_select_mining_shape(shape: Array[Vector2i]) -> void:
	_mining_tile_map.set_mining_shape(shape)

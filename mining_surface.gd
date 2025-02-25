extends SubViewportContainer

@export var map_target_rect: Rect2i = Rect2i(Vector2i.ZERO, Vector2i(1, 1))

@export var _camera: TargetScaleCamera
@export var _mining_tile_map: MiningTileMap
@export var _treasure_tile_map: TreasureTileMap

func _ready() -> void:
	_mining_tile_map.map_ready.connect(_on_map_ready)
	_treasure_tile_map.map_target_rect = map_target_rect
	_treasure_tile_map.spawn_treasures(5)

func _on_map_ready(target_rect: Rect2):
	_camera.target = target_rect

#func _draw():
	#await get_tree().process_frame
	#_camera.scale_camera()

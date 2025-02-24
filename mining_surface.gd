extends SubViewportContainer

@export var camera: TargetScaleCamera
@export var mining_tile_map: MiningTileMap

func _ready() -> void:
	mining_tile_map.map_ready.connect(_on_map_ready)

func _on_map_ready(target_rect: Rect2):
	camera.target = target_rect

#func _draw():
	#await get_tree().process_frame
	#camera.scale_camera()

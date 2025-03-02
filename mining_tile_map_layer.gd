extends TileMapLayer

signal mining_tile_activated

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Logger.trace(str(get_child_count()))
	Logger.trace(str(get_used_cells().size()))
	for cell_pos in get_used_cells():
		var source_id = get_cell_source_id(cell_pos)
		if source_id > -1:
			var scene_source = tile_set.get_source(source_id)
			if scene_source is TileSetScenesCollectionSource:
				var alt_id = get_cell_alternative_tile(cell_pos)
				# The assigned PackedScene.
				var scene: PackedScene = scene_source.get_scene_tile_scene(alt_id)
				Logger.trace(scene.resource_name)
				#if scene is MiningTile:
					#Logger.trace("Adding MiningTile child to mining tile map")
					#scene.mining_tile_activated.connect(_on_mining_tile_activated)
	#
	#


func _draw() -> void:
	await get_tree().process_frame
	for child in get_children():
		if child is MiningTile:
			Logger.trace("Adding MiningTile child to mining tile map")
			child.mining_tile_activated.connect(_on_mining_tile_activated)

func _on_mining_tile_activated():
	mining_tile_activated.emit()

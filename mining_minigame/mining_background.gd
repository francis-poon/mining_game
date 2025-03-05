class_name MiningBackgroundTileMap
extends TileMapLayer

@export var border_thickness: int = 3

@export var border_tile_source_id: int
@export var border_tile_atlas_coord: Vector2i

@export var background_tile_source_id: int
@export var background_tile_atlas_coord: Vector2i

func new_game(p_map_target_rect: Rect2i):
	var border_target_rect = Rect2i(p_map_target_rect.position - Vector2i(border_thickness, border_thickness),
	p_map_target_rect.size + Vector2i(2 * border_thickness, 2 * border_thickness))
	
	for x_pos in border_target_rect.size.x:
		for y_pos in border_target_rect.size.y:
			var pos: Vector2i = border_target_rect.position + Vector2i(x_pos, y_pos)
			if p_map_target_rect.has_point(pos):
				set_cell(pos, tile_set.get_source_id(background_tile_source_id), background_tile_atlas_coord)
			else:
				set_cell(pos, tile_set.get_source_id(border_tile_source_id), border_tile_atlas_coord)

extends Node2D

@export var ref_tml: TileMapLayer
@export var target_tml: TileMapLayer

var placed_patterns: Array[Rect2i] = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	target_tml.tile_set = ref_tml.tile_set
	for cell_pos in ref_tml.get_used_cells():
		target_tml.set_pattern(cell_pos, target_tml.tile_set.get_pattern(0))
	print(Vector2i(0,1) + Vector2i(1,1))
	print(str(target_tml.tile_set.get_pattern(0).get_used_cells()))

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.is_pressed():
		var new_pattern_placement: Rect2i = Rect2i(
			target_tml.local_to_map(get_local_mouse_position()), target_tml.tile_set.get_pattern(0).get_size())
		for pattern_rect in placed_patterns:
			if pattern_rect.intersects(new_pattern_placement):
				return
		placed_patterns.append(new_pattern_placement)
		target_tml.set_pattern(new_pattern_placement.position, target_tml.tile_set.get_pattern(0))

extends Node2D

@export var tml: TileMapLayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	tml.tile_set.get_pattern(0)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

class_name TreasureCollection
extends Resource

@export var tile_set: TileSet
@export var small_treasures: Array[Treasure]
@export var medium_treasures: Array[Treasure]

func _init(p_tile_set: TileSet = TileSet.new(), p_small_treasures: Array[Treasure] = [],
	p_medium_treasures: Array[Treasure] = []):
	tile_set = p_tile_set
	small_treasures = p_small_treasures
	medium_treasures = p_medium_treasures

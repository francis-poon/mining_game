class_name MiningButton
extends TextureButton

signal mining_button_down(pos: Vector2)

@export var mining_textures: Array[Texture2D]

var grid_position: Vector2 = Vector2.ZERO
var mining_value: int:
	set(value):
		mining_value = value
		var new_stylebox: StyleBox
		if value in range(mining_textures.size()):
			texture_normal = mining_textures[value]

func _ready() -> void:
	mining_value = mining_textures.size() - 1

func decrement_value():
	if mining_value > 0:
		mining_value -= 1

func _on_button_down() -> void:
	mining_button_down.emit(grid_position)

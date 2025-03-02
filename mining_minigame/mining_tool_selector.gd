class_name MiningToolSelector
extends VBoxContainer

signal select_mining_shape(shape: Array[Vector2i])

@export var default_mining_tool: MiningToolButton

# Called when the node enters the scene tree for the first time.
func _ready():
	for child in get_children():
		if child is MiningToolButton:
			child.select_mining_shape.connect(_on_select_mining_shape)

func new_game():
	default_mining_tool.button_pressed = true

func _draw():
	await get_tree().process_frame
	default_mining_tool.button_pressed = true

func _on_select_mining_shape(shape: Array[Vector2i]):
	select_mining_shape.emit(shape)

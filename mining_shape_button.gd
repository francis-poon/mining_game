extends Button

signal select_mining_shape(shape: Array[Vector2i])

@export var mining_shape: Array[Vector2i] = [Vector2i.ZERO]

func _ready() -> void:
	pressed.connect(_on_pressed)

func _on_pressed():
	select_mining_shape.emit(mining_shape)

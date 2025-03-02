class_name MiningToolButton
extends Button

signal select_mining_shape(shape: Array[Vector2i])

@export var mining_shape: Array[Vector2i] = [Vector2i.ZERO]

func _ready() -> void:
	toggled.connect(_on_toggled)


func _on_toggled(toggled_on):
	if toggled_on:
		select_mining_shape.emit(mining_shape)

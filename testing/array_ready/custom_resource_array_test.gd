extends Node2D

@export var custom_res_array: Array

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print(custom_res_array.size())

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

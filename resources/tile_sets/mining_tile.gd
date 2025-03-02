class_name MiningTile
extends Sprite2D

signal mining_tile_activated

var interact: bool

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	interact = false

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("interact") and interact:
		Logger.trace("MiningTile activated")
		mining_tile_activated.emit()

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Player:
		interact = true

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body is Player:
		interact = false

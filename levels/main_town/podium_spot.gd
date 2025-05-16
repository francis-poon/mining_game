class_name PodiumSpot
extends Node2D

@export var codex_id: int
@export var texture: Texture2D
@export var _sprite: Sprite2D
@export var _description_label: Label
@export var _description_control: Control

var unlocked:
	set(value):
		unlocked = value
		if unlocked:
			_sprite.show()
			_unlock_label()
		else:
			_description_label.text = "???"
			_sprite.hide()
	
func _ready() -> void:
	_sprite.texture = texture
	_description_control.hide()
	unlocked = false
	

func unlock():
	unlocked = true

func _unlock_label():
	var _item_manager: ItemManager = get_tree().get_first_node_in_group("ItemManager")
	_description_label.text = "{0}: {1}\n".format([
		_item_manager.get_item(codex_id).item_name,
		_item_manager.get_item(codex_id).description])

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Player:
		_description_control.show()

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body is Player:
		_description_control.hide()

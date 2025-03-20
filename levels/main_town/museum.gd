class_name Museum
extends Level

@export var _podium_spots: Node

func _ready() -> void:
	super._ready()
	var codex: Codex = get_tree().get_first_node_in_group("Codex") as Codex
	for child in _podium_spots.get_children():
		for codex_id in codex.data.unlocked_ids.keys():
			if child is PodiumSpot and child.codex_id == codex_id:
				child.unlock()

func on_codex_changed(codex_data: CodexData):
	for child in _podium_spots.get_children():
		for codex_id in codex_data.unlocked_ids.keys():
			if child is PodiumSpot and child.codex_id == codex_id:
				child.unlock()

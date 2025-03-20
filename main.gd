extends Node2D

signal main_ready

@export var item_manager: ItemManager
@export var inventory: PlayerInventory
@export var codex: Codex
@export var _player: Player
@export var _level_manager: LevelManager

var save_dir: String = "res://saves/"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_load_game()

#func _draw() -> void:
	#await get_tree().process_frame
	#Logger.trace(item_manager.get_item(0).name)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("save"):
		_save_game()

func _load_game():
	DirAccess.make_dir_absolute(save_dir)
	for node in get_tree().get_nodes_in_group("Saveable"):
		if not node.has_method("load_data"):
			Logger.warn("Node {0} is in group \"Saveable\" but does not have load_data method".format([node.name]))
			continue
		node.load_data(save_dir)

func _save_game():
	for node in get_tree().get_nodes_in_group("Saveable"):
		if not node.has_method("save_data"):
			Logger.warn("Node {0} is in group \"Saveable\" but does not have save_data method".format([node.name]))
			continue
		node.save_data(save_dir)

func _on_game_over(item_drops: InventoryData) -> void:
	inventory.add_items(item_drops)


func _on_teleport_player(pos: Vector2) -> void:
	_player.position = pos
	await get_tree().process_frame
	_level_manager.unpause_teleports()

func _on_inventory_change(item_data: InventoryData) -> void:
	inventory.add_items(item_data)
	codex.add_codex_entries(item_data.item_count.keys())
	Logger.trace(str(item_data.item_count.keys()))


func _on_codex_changed(codex_data: CodexData) -> void:
	_level_manager.on_codex_changed(codex_data)


func _on_level_ready() -> void:
	_player.position = _level_manager.current_level.get_default_spawn_point()
	
	await get_tree().process_frame
	_level_manager.on_main_ready()

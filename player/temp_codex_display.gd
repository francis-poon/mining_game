extends PanelContainer

@export var inv_label: Label

var _item_manager: ItemManager

func _ready():
	_item_manager = get_tree().get_first_node_in_group("ItemManager")
	hide()

func _input(event: InputEvent):
	if event.is_action_pressed("codex"):
		visible = !visible


func _on_codex_codex_changed(codex_data: CodexData) -> void:
	inv_label.text = ""
	for item_id in codex_data.unlocked_ids:
		inv_label.text += "{0}: {1}\n".format([
			_item_manager.get_item(item_id).item_name,
			_item_manager.get_item(item_id).description])

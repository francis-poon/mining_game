extends PanelContainer

@export var inv_label: Label

var _item_manager: ItemManager

func _ready():
	_item_manager = get_tree().get_first_node_in_group("ItemManager")
	hide()

func _input(event: InputEvent):
	if event.is_action_pressed("inventory"):
		visible = !visible


func _on_inventory_inventory_changed(inventory_data: InventoryData):
	inv_label.text = ""
	for item_id in inventory_data.item_count:
		inv_label.text += "{0}: {1}\n".format([
			_item_manager.get_item(item_id).item_name,
			inventory_data.item_count[item_id]])

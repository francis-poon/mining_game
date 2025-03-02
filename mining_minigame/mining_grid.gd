extends GridContainer

@export var grid_size: Vector2
@export var mining_button: PackedScene

var mining_array: Array[Array]

func _ready() -> void:
	mining_array = []
	mining_array.resize(grid_size.x)
	columns = grid_size.y
	for row in range(grid_size.x):
		var mining_row = []
		mining_row.resize(grid_size.y)
		mining_array[row] = mining_row
		for col in range(grid_size.y):
			var mining_button: MiningButton = mining_button.instantiate()
			mining_button.grid_position = Vector2(row, col)
			mining_button.mining_button_down.connect(_on_mining_button_down)
			mining_array[row][col] = mining_button
			add_child(mining_button)

func _on_mining_button_down(pos: Vector2):
	mining_array[pos.x][pos.y].decrement_value()
	if pos.x - 1 >= 0:
		mining_array[pos.x - 1][pos.y].decrement_value()
	if pos.x + 1 < mining_array.size():
		mining_array[pos.x + 1][pos.y].decrement_value()
	if pos.y - 1 >= 0:
		mining_array[pos.x][pos.y - 1].decrement_value()
	if pos.y + 1 < mining_array[pos.x].size():
		mining_array[pos.x][pos.y + 1].decrement_value()

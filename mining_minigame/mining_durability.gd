extends ProgressBar

signal durability_broken

func _ready() -> void:
	value = min_value

func new_game():
	value = min_value

func _on_mine(amount: float):
	if value + amount > max_value:
		durability_broken.emit()
	else:
		value += amount

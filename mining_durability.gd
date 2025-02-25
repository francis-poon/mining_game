extends ProgressBar

signal durability_broken

func _ready() -> void:
	value = 0

func _on_mine(amount: float):
	if value + amount > max_value:
		durability_broken.emit()
	else:
		value += amount

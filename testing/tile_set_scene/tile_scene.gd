extends Sprite2D

var interact: bool

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	interact = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("interact") and interact:
		print("asdf")


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Player:
		interact = true

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body is Player:
		interact = false

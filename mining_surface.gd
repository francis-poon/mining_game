extends SubViewportContainer

@export var camera: AutoScaleCamera

func _draw():
	await get_tree().process_frame
	camera.scale_camera()
	print(size)

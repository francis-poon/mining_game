class_name TargetScaleCamera
extends Camera2D

var target: Rect2:
	set(value):
		Logger.trace("Setting camera target")
		target = value
		_scale_camera()

func _scale_camera():
	var viewport_aspect_ratio = get_viewport_rect().size.x / get_viewport_rect().size.y
	var target_aspect_ratio = target.size.x / target.size.y
	var cam_zoom
	if target_aspect_ratio > viewport_aspect_ratio:
		cam_zoom  = get_viewport_rect().size.x / target.size.x
	else:
		cam_zoom = get_viewport_rect().size.y / target.size.y
	zoom = Vector2(cam_zoom, cam_zoom)
	position = target.position + (target.size / 2)

class_name AutoScaleCamera
extends Camera2D

@export var target: Control

func scale_camera():
	var viewport_aspect_ratio = get_viewport_rect().size.x / get_viewport_rect().size.y
	
	var target_size = target.get_rect().size
	var target_aspect_ratio = target_size.x / target_size.y
	
	var cam_zoom
	if target_aspect_ratio > viewport_aspect_ratio:
		cam_zoom  = get_viewport_rect().size.x / target_size.x
	else:
		cam_zoom  = get_viewport_rect().size.y / target_size.y
	zoom = Vector2(cam_zoom, cam_zoom)
	position = target.position + target.get_rect().size / 2

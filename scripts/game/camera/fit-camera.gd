extends Node
class_name FitCamera

@export var camera: Camera2D

@onready var control: Control = get_parent()

func _process(_delta: float) -> void:
	if not camera:
		return
	_fit_to_camera()
	
func _fit_to_camera() -> void:
	var viewport := get_viewport()
	var viewport_size := Vector2(viewport.get_visible_rect().size)
	var zoom := camera.zoom
	var world_size := viewport_size / zoom

	var center := camera.get_screen_center_position()
	
	control.global_position = center - world_size / 2.0
	control.size = world_size

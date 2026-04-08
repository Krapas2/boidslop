extends Node
class_name FitCamera

@export var camera: Camera2D

@onready var control: Control = get_parent()

func _process(_delta: float) -> void:
	if not camera:
		return
	_fit_to_camera()
	
func _fit_to_camera() -> void:
	var viewport: Viewport = get_viewport()
	var viewport_size: Vector2 = Vector2(viewport.get_visible_rect().size)
	var zoom: Vector2 = camera.zoom
	var world_size: Vector2 = viewport_size / zoom

	var center: Vector2 = camera.get_screen_center_position()
	
	control.global_position = center - world_size / 2.0
	control.size = world_size

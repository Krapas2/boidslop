extends Node
class_name CameraController

@export var move_speed: float
@export var zoom_speed: float
@export var damping: float
@export var minimum_zoom: float
@export var maximum_zoom: float
@export var zoom_margin: float

var targets: Dictionary[String, Vector2]
var additional_zooms: Dictionary[String, float]

var _move_velocity: Vector2 = Vector2.ZERO
var _zoom_velocity: float = 0.0

@onready var camera: Camera2D = get_parent()
@onready var starting_zoom: float = camera.zoom.x

static var instance: CameraController = null

func _enter_tree() -> void:
	instance = self

func _exit_tree() -> void:
	instance = null

func _process(delta: float) -> void:
	_apply_position(delta)
	_apply_zoom(delta)

func _apply_position(delta: float) -> void:
	var desired: Vector2 = _get_position()
	var displacement: Vector2 = desired - camera.global_position
	
	_move_velocity = _move_velocity.lerp(displacement * move_speed, 1.0 - damping)
	camera.global_position += _move_velocity * delta

func _apply_zoom(delta: float) -> void:
	var desired_zoom: float = _get_fit_zoom() + _get_additional_zoom()
	var displacement: float = desired_zoom - camera.zoom.x
	
	_zoom_velocity = lerp(_zoom_velocity, displacement * zoom_speed, 1.0 - damping)
	var new_zoom: float = camera.zoom.x + _zoom_velocity * delta
	camera.zoom = Vector2.ONE * new_zoom

func _get_position() -> Vector2:
	return Vector2Utils.get_average(targets.values())

func _get_additional_zoom() -> float:
	return FloatUtils.get_average(additional_zooms.values())

func _get_fit_zoom() -> float:
	if targets.is_empty():
		return starting_zoom
	
	var bounding_box: Rect2 = _calculate_targets_bounding_box()
	return _calculate_optimal_zoom(bounding_box)

func _calculate_targets_bounding_box() -> Rect2:
	var target_positions: Array[Vector2] = targets.values()
	var rect: Rect2 = Rect2(target_positions[0], Vector2.ZERO)
	
	for pos: Vector2 in target_positions:
		rect = rect.expand(pos)
	
	return rect

func _calculate_optimal_zoom(rect: Rect2) -> float:
	var margin: Vector2 = Vector2(zoom_margin, zoom_margin)
	rect = rect.grow_individual(margin.x, margin.y, margin.x, margin.y)
	
	var viewport_size: Vector2 = get_viewport().get_visible_rect().size
	var square_viewport_side: float = min(viewport_size.x, viewport_size.y)
	var square_viewport: Vector2 = Vector2(square_viewport_side, square_viewport_side)
	var zoom_factor: Vector2 = square_viewport / rect.size
	var fit_zoom: float = min(zoom_factor.x, zoom_factor.y)
	
	return clamp(fit_zoom, minimum_zoom, maximum_zoom)

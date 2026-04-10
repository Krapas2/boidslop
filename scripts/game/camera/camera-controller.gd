extends Node
class_name CameraController

@export_group("Movement")
@export var move_speed: float
@export_range(0, 1) var move_damping: float
@export_group("Zoom")
@export var zoom_speed: float
@export_range(0, 1) var zoom_damping: float
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
	
	_move_velocity = _move_velocity.lerp(displacement * move_speed, 1.0 - move_damping)
	camera.global_position += _move_velocity * delta

func _apply_zoom(delta: float) -> void:
	var desired_zoom: float = _get_fit_zoom() + _get_additional_zoom()
	var displacement: float = desired_zoom - camera.zoom.x
	
	_zoom_velocity = lerp(_zoom_velocity, displacement * zoom_speed, 1.0 - zoom_damping)
	var new_zoom: float = camera.zoom.x + _zoom_velocity * delta
	camera.zoom = Vector2.ONE * new_zoom

func _get_position() -> Vector2:
	return Vector2Utils.get_average(targets.values())

func _get_additional_zoom() -> float:
	return FloatUtils.get_average(additional_zooms.values())

func _get_fit_zoom() -> float:
	if targets.is_empty():
		return starting_zoom
	
	var bounding_circle: BoundingCircle = _calculate_targets_bounding_circle()
	return _calculate_optimal_zoom(bounding_circle)
	
func _calculate_targets_bounding_circle() -> BoundingCircle:
	var target_positions: Array[Vector2] = targets.values()

	var center: Vector2 = target_positions[0]
	var radius: float = 0.0

	for pos: Vector2 in target_positions:
		var dist: float = center.distance_to(pos)
		if dist > radius:
			var new_radius: float = (radius + dist) / 2.0
			center = center + (pos - center).normalized() * (new_radius - radius)
			radius = new_radius

	return BoundingCircle.new(center, radius)

func _calculate_optimal_zoom(circle: BoundingCircle) -> float:
	var radius: float = circle["radius"] + zoom_margin
	var diameter: float = radius * 2.0

	var viewport_size: Vector2 = get_viewport().get_visible_rect().size
	var square_viewport_side: float = min(viewport_size.x, viewport_size.y)
	var fit_zoom: float = square_viewport_side / diameter

	return clamp(fit_zoom, minimum_zoom, maximum_zoom)

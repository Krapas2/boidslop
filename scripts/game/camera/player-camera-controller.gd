extends Node
class_name PlayerCameraController

@export var target: Node2D
@export var leading_distance: float
@export var movement_lerp_speed: float

@export var pixel_units_height: float
@export var zoom_out_power: float
@export var zoom_lerp_speed: float

@onready var camera: Camera2D = get_parent()

var position_to_follow: Vector2

func _ready() -> void:
	position_to_follow = camera.global_position

func _process(delta: float) -> void:
	var screen_center: Vector2 = get_viewport().size/2
	var screen_mouse_position: Vector2 = get_viewport().get_mouse_position() 
	
	var camera_vector: Vector2 = VectorUtils.clamp_magnitude_v2(
		(screen_mouse_position - screen_center) / screen_center.y,
		1
	)
	
	set_position_to_follow()
	call_deferred("movement", camera_vector, delta)
	call_deferred("zoom", camera_vector.length(), delta)

func set_position_to_follow() -> void:
	if target:
		position_to_follow = target.global_position

func movement(vector: Vector2, delta: float) -> void:
	var desired_position: Vector2 = position_to_follow + (vector * leading_distance)
	
	camera.global_position = lerp(
		camera.global_position,
		desired_position,
		movement_lerp_speed * delta
	)

func zoom(intensity: float, delta: float) -> void:
	var zoom_ratio: float = get_viewport().size.y / pixel_units_height
	var base_zoom: Vector2 = zoom_ratio * Vector2.ONE
	var desired_zoom: Vector2 = lerp(
		base_zoom,
		base_zoom * zoom_out_power,
		intensity
	)
	
	camera.zoom = lerp(
		desired_zoom,
		camera.zoom,
		zoom_lerp_speed * delta
	)

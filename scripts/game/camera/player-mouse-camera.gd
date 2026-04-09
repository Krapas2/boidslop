extends Node
class_name PlayerMouseCamera

@export var player: Node2D
@export var min_leading_distance: float
@export var max_leading_distance: float

@onready var camera_controller: CameraController = CameraController.instance

const PLAYER_TARGET_KEY: String = "PLAYER_TARGET"
const MOUSE_TARGET_KEY: String = "MOUSE_TARGET"

func _process(_delta: float) -> void:
	camera_controller.targets[PLAYER_TARGET_KEY] = player.global_position
	camera_controller.targets[MOUSE_TARGET_KEY] = _get_mouse_target_position()

func _get_mouse_target_position() -> Vector2:
	var screen_center: Vector2 = get_viewport().size * .5
	var screen_mouse_position: Vector2 = get_viewport().get_mouse_position()
	
	var camera_vector: Vector2 = Vector2Utils.clamp_magnitude(
		((screen_mouse_position - screen_center) / screen_center.y) * max_leading_distance,
		min_leading_distance,
		max_leading_distance
	)
	
	return player.global_position + camera_vector

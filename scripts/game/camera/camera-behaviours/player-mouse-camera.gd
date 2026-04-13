extends Node
class_name PlayerMouseCamera

@export var player: Node2D
@export var leading_distance_curve: Curve

@onready var camera_controller: CameraController = CameraController.instance

const PLAYER_TARGET_KEY: String = "PLAYER_TARGET"
const MOUSE_TARGET_KEY: String = "MOUSE_TARGET"

func _process(_delta: float) -> void:
	if player:
		camera_controller.targets[PLAYER_TARGET_KEY] = player.global_position
		camera_controller.targets[MOUSE_TARGET_KEY] = _get_mouse_target_position()
	else :
		camera_controller.targets.erase(PLAYER_TARGET_KEY)
		camera_controller.targets.erase(MOUSE_TARGET_KEY)

func _get_mouse_target_position() -> Vector2:
	var screen_center: Vector2 = get_viewport().size * .5
	var screen_mouse_position: Vector2 = get_viewport().get_mouse_position()
	
	var offset: Vector2 = (screen_mouse_position - screen_center) / screen_center.y
	var normalized_magnitude: float = clamp(offset.length(), 0.0, 1.0)
	var camera_vector: Vector2 = (
		offset.normalized() *
		leading_distance_curve.sample_baked(normalized_magnitude)
	)
	
	return player.global_position + camera_vector

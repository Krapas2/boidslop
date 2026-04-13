extends Node
class_name PlayerNetProximityZoom

# TODO: curve could achieve the same behaviour while giving more control
@export var zoom_power: float
@export var max_distance: float
@export var filled_net_detector: FilledNetDetector

@onready var player: Node2D = get_parent()
@onready var camera_controller: CameraController = CameraController.instance

const CHARGE_ZOOM_KEY: String = "NET_PROXIMITY_ZOOM"

func _physics_process(_delta: float) -> void:
	camera_controller.additional_zooms[CHARGE_ZOOM_KEY] = _calculated_zoom()
	
func _calculated_zoom() -> float:
	var distance_to_net: float = _get_parsed_distance_to_net()
	return remap(
		distance_to_net,
		max_distance,
		0,
		0,
		zoom_power
	)

func _get_parsed_distance_to_net() -> float:
	return min(filled_net_detector.closest_filled_net_distance, max_distance)

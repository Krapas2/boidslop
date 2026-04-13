extends Node
class_name PlayerNetCameraTarget

@export var filled_net_detector: FilledNetDetector

@onready var camera_controller: CameraController = CameraController.instance

const CLOSEST_NET_TARGET_KEY: String = "CLOSEST_NET_TARGET"

func _process(_delta: float) -> void:
	if filled_net_detector.closest_filled_net == null:
		camera_controller.targets.erase(CLOSEST_NET_TARGET_KEY)
	else:
		camera_controller.targets[CLOSEST_NET_TARGET_KEY] = \
			filled_net_detector.closest_filled_net.global_position

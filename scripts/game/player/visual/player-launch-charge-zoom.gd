extends Node
class_name PlayerLaunchChargeZoom

@export var zoom_power: float

@onready var player_launch: PlayerLaunch = get_parent()
@onready var camera_controller: CameraController = CameraController.instance

const CHARGE_ZOOM_KEY: String = "CHARGE_ZOOM"

func _process(_delta: float) -> void:
	camera_controller.additional_zooms[CHARGE_ZOOM_KEY] = _calculated_zoom()
	
func _calculated_zoom() -> float:
	return remap(
		player_launch.charge,
		0,
		player_launch.charge_time,
		0,
		zoom_power
	)

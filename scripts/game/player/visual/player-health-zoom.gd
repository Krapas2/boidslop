extends Node
class_name PlayerHealthZoom

# TODO: curve could achieve the same behaviour while giving more control
@export var zoom_power: float

@onready var player_health: Health = get_parent()
@onready var camera_controller: CameraController = CameraController.instance

const CHARGE_ZOOM_KEY: String = "HEALTH_ZOOM"

func _process(_delta: float) -> void:
	camera_controller.additional_zooms[CHARGE_ZOOM_KEY] = _calculated_zoom()
	
func _calculated_zoom() -> float:
	return remap(
		player_health.current_health,
		player_health.max_health,
		0,
		0,
		zoom_power
	)

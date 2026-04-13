extends Node
class_name PlayerNetProximityZoom

# TODO: curve could achieve the same behaviour while giving more control
@export var zoom_power: float
@export var max_distance: float
@export var detect_net_area: Area2D

@onready var player: Node2D = get_parent()
@onready var camera_controller: CameraController = CameraController.instance

const CHARGE_ZOOM_KEY: String = "NET_PROXIMITY_ZOOM"

func _physics_process(_delta: float) -> void:
	camera_controller.additional_zooms[CHARGE_ZOOM_KEY] = _calculated_zoom()
	
func _calculated_zoom() -> float:
	var distance_to_net: float = _get_distance_to_closest_net()
	return remap(
		distance_to_net,
		max_distance,
		0,
		0,
		zoom_power
	)

func _get_distance_to_closest_net() -> float:
	var nets: Array[Node2D] = detect_net_area.get_overlapping_bodies()
	if nets.is_empty():
		return max_distance
	
	var shortest_distance: float = INF
	for net: Node2D in nets:
		var distance: float = net.global_position.distance_to(player.global_position)
		if distance < shortest_distance:
			shortest_distance = distance
	return shortest_distance

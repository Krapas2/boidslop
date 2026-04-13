extends Node
class_name FilledNetDetector

var closest_filled_net: Node2D
var closest_filled_net_distance: float

@onready var detect_net_area: Area2D = get_parent()

func _physics_process(_delta: float) -> void:
	_get_to_closest_filled_net()

func _get_to_closest_filled_net() -> void:
	var nets: Array[Node2D] = detect_net_area.get_overlapping_bodies()
	
	var closest_net: Node2D = null
	var closest_net_distance: float = INF
	for net: Node2D in nets:
		var net_behaviour: PlayerNetBehaviour = net.get_node("PlayerNetBehaviour")
		if !net_behaviour || net_behaviour.bodies_consumed <= 0:
			continue
		var net_distance: float = \
			detect_net_area.global_position.distance_to(net.global_position)
		if net_distance < closest_net_distance:
			closest_net_distance = net_distance
			closest_net = net
			
	closest_filled_net = closest_net
	closest_filled_net_distance = closest_net_distance

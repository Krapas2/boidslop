extends Node
class_name PlayerHeadChomp

@export var head_animation_player: AnimationPlayer
@export var point_at_target_behaviour: PointAtTarget
@export var detect_net_area: Area2D

@onready var player_head_pivot: Node2D = get_parent()
@onready var original_head_rotation: float = player_head_pivot.rotation

func _process(_delta: float) -> void:
	var nets: Array[Node2D] = detect_net_area.get_overlapping_bodies()
	var closest_net: Node2D = _get_closest_viable_net(nets)
	if !closest_net:
		_reset_rotation()
		head_animation_player.play("idle")
		return
	point_at_target_behaviour.target = closest_net
	head_animation_player.play("chomp-gape")

func _reset_rotation() -> void:
	point_at_target_behaviour.target = null
	player_head_pivot.rotation = original_head_rotation

func _get_closest_viable_net(nets: Array[Node2D]) -> Node2D:
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
	return closest_net

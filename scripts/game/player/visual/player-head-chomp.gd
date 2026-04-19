extends Node
class_name PlayerHeadChomp

@export var head_animation_player: AnimationPlayer
@export var point_at_target_behaviour: PointAtTarget
@export var filled_net_detector: FilledNetDetector

@onready var player_head_pivot: Node2D = get_parent()
@onready var original_head_rotation: float = player_head_pivot.rotation

func _process(_delta: float) -> void:
	var closest_net: Node2D = filled_net_detector.closest_filled_net
	if !closest_net:
		_reset_rotation()
		head_animation_player.play("idle")
		return
	point_at_target_behaviour.target = closest_net
	head_animation_player.play("chomp-gape")

func _reset_rotation() -> void:
	point_at_target_behaviour.target = null
	player_head_pivot.rotation = original_head_rotation

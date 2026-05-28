extends Node
class_name BossStunProjectile

@export var stun_area: Area2D

@onready var root: Node = get_parent()
@onready var length: Timer = $Length

var _player_walk: PlayerWalk = null
var _original_player_speed: float

func _physics_process(_delta: float) -> void:
	if !_player_walk:
		_collide_behaviour()
	else:
		_stun_length_behaviour()
	
func _collide_behaviour() -> void:
	var overlapping_bodies: Array[Node2D] = stun_area.get_overlapping_bodies()
	if overlapping_bodies.size() <= 0:
		return
	
	_player_walk = _get_player_walk(overlapping_bodies)
	if _player_walk.speed > 0:
		_apply_stun()
	else:
		_already_stunned()

func _get_player_walk(overlapping_bodies: Array[Node2D]) -> PlayerWalk:
	# only one body should exist in the player layer
	var player_body: RigidBody2D = overlapping_bodies[0]
	return player_body.get_node("PlayerWalk")

func _already_stunned() -> void:
	queue_free()

func _apply_stun() -> void:
	reparent(_player_walk)
	root.queue_free()
	_original_player_speed = _player_walk.speed
	_player_walk.speed = 0
	length.start()

func _stun_length_behaviour() -> void:
	if length.time_left > 0:
		return
	
	_player_walk.speed = _original_player_speed
	queue_free()

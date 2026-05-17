extends Node
class_name BossIdleTool

@export var radius: float
@export var acceleration: float
@export var max_lean_velocity: float
@export var distance_to_get_new_position: float
@export var enabled: bool:
	set(value):
		enabled = value
		if value:
			_should_reset_following_position = true

@onready var center: Node2D = $Center
@onready var body: RigidBody2D = get_parent()
@onready var starting_rotation: float = body.rotation

var _should_reset_following_position: bool
var _following_position: Vector2

func _physics_process(delta: float) -> void:
	if !enabled:
		return
	
	_set_following_position()
	_follow_position(delta)
	_lean()

func _set_following_position() -> void:
	var near_follow_position: bool = \
		body.global_position.distance_to(_following_position) < distance_to_get_new_position
	if !(_should_reset_following_position || near_follow_position):
		return
	_should_reset_following_position = false
	
	var new_pos_angle: float = randf() * 2*PI
	var new_pos_distance: float = randf() * radius
	var new_pos: Vector2 = \
		Vector2(
			cos(new_pos_angle),
			sin(new_pos_angle)
		) * new_pos_distance
	_following_position = center.global_position + new_pos
	
func _follow_position(delta: float) -> void:
	var displacement: Vector2 = _following_position - body.global_position
	body.linear_velocity += displacement.normalized() * acceleration * delta
	
func _lean() -> void:
	var lean_intensity: float = body.linear_velocity.x / max_lean_velocity
	body.rotation = starting_rotation + atan(lean_intensity)
	

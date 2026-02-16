extends BossBehaviour
class_name ChaseBossBehaviour

@export var player_body: RigidBody2D

@export_group("Behaviour")
@export var chasing_bodies: Array[RigidBody2D]
@export var max_speed: float
@export var max_force: float

@export_group("Priority")
@export var base_travel_speed: float
@export var distance_priority_unit: float

var traveled_distance: float = 0
var passed_time: float = 0

func _physics_process(delta: float) -> void:
	count_player_travel(delta)
	if enabled:
		chase_behaviour(delta)

func count_player_travel(delta: float) -> void:
	if !player_body:
		return
	traveled_distance += player_body.linear_velocity.length() * delta
	passed_time += delta

func reset_player_travel() -> void:
	traveled_distance = 0
	passed_time = 0

func priority() -> float:
	var calculated_priority = base_travel_speed - (traveled_distance / passed_time) / distance_priority_unit
	reset_player_travel()
	return calculated_priority

func chase_behaviour(delta: float) -> void:
	for chasing_body: RigidBody2D in chasing_bodies:
		individual_chase_behaviour(chasing_body, delta)
		individual_heading_behaviour(chasing_body)

func individual_chase_behaviour(chasing_body: RigidBody2D, delta: float) -> void:
	var relative_position: Vector2 = player_body.global_position-chasing_body.global_position
	var desired_velocity: Vector2 = relative_position.normalized() * max_speed
	var acceleration = VectorUtils.clamp_magnitude(
		desired_velocity-chasing_body.linear_velocity,
		max_force
	)
	
	chasing_body.linear_velocity += acceleration * delta

func individual_heading_behaviour(chasing_body: RigidBody2D) -> void:
	var angle: float = atan2(chasing_body.linear_velocity.x, -chasing_body.linear_velocity.y)
	chasing_body.rotation = angle

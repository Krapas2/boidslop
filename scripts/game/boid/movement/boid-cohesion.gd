extends BoidMovementBehaviour
class_name BoidCohesion

@export var perception_radius: float
@export var max_force: float
@export var strength: float

@onready var movement_manager: BoidMovementManager = get_parent()

func _ready() -> void:
	_enter_manager()

func _enter_manager() -> void: 
	movement_manager.behaviours.append(self)

func boid_velocity() -> Vector2:
	var flockmates: Array[RigidBody2D] = \
		movement_manager.flock_manager.get_flockmates(
			movement_manager.body,
			perception_radius
		)
	
	if flockmates.size() <= 0:
		return Vector2.ZERO
	
	var force: Vector2 = cohesion(flockmates)
	
	return force.limit_length(max_force)

func cohesion(flockmates: Array[RigidBody2D]) -> Vector2:
	var mates_position_sum: Vector2 = Vector2.ZERO
	for flockmate: Node2D in flockmates:
		mates_position_sum += flockmate.global_position
	var mates_position_average: Vector2 = mates_position_sum / flockmates.size()
	var desired_velocity: Vector2 = mates_position_average - movement_manager.body.global_position
	desired_velocity = desired_velocity.normalized() * strength
	var steering: Vector2 = desired_velocity - movement_manager.body.linear_velocity
	
	return steering

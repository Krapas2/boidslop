extends BoidMovementBehaviour
class_name BoidSeparation

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
		movement_manager.flock_manager._get_flockmates(
			movement_manager.body,
			perception_radius
		)
	
	if flockmates.size() <= 0:
		return Vector2.ZERO
	
	var force: Vector2 = separation(flockmates)
	
	return VectorUtils.clamp_magnitude(
		force,
		max_force
	)

func separation(flockmates: Array[RigidBody2D]) -> Vector2:
	var mate_avoid_sum: Vector2 = Vector2.ZERO
	for flockmate: RigidBody2D in flockmates:
		var relative_position = movement_manager.body.global_position - flockmate.global_position;
		mate_avoid_sum += relative_position / movement_manager.body.global_position.distance_squared_to(flockmate.global_position)
	var mate_avoid_average = mate_avoid_sum / flockmates.size()
	var desired_velocity = mate_avoid_average.normalized() * strength
	var steering = desired_velocity - movement_manager.body.linear_velocity
	
	return steering

extends BoidMovementBehaviour
class_name BoidAlignment

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
	
	var force: Vector2 = alignment(flockmates)
	
	return VectorUtils.clamp_magnitude(
		force,
		max_force
	)

func alignment(flockmates: Array[RigidBody2D]) -> Vector2:
	var mates_velocity_sum: Vector2 = Vector2.ZERO
	for flockmate: RigidBody2D in flockmates:
		mates_velocity_sum += flockmate.linear_velocity
	var desired_velocity = mates_velocity_sum.normalized() * strength
	var steering = desired_velocity - movement_manager.body.linear_velocity
	
	return steering

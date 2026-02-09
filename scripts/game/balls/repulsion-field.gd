extends Area2D
class_name RepulsionField

@export var strength: float
@export var distance_unit: float

func _process(delta: float) -> void:
	var relevant_bodies: Array[RigidBody2D] = bodies_in_radius()
	apply_force(relevant_bodies, delta)
	
func bodies_in_radius() -> Array[RigidBody2D]:
	var bodies: Array[RigidBody2D] = []
	var overlapping_bodies: Array[Node2D] = get_overlapping_bodies()
	
	for body in overlapping_bodies:
		if body is RigidBody2D:
			bodies.append(body)
	return bodies
	
func apply_force(bodies: Array[RigidBody2D], delta: float) -> void:
	for body: RigidBody2D in bodies:
		var relative_position: Vector2 = body.global_position-global_position
		var force: float = force_magnitude(relative_position.length()) * delta
		
		body.linear_velocity += relative_position.normalized() * force

func force_magnitude(distance: float) -> float:
	var scaled_distance: float = distance / distance_unit
	return strength / (scaled_distance * scaled_distance + 1.0)

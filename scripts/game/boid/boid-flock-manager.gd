extends Node
class_name BoidFlockManager

var flock: Array[RigidBody2D]

func _get_flockmates(boid: Node2D, perception: float) -> Array[RigidBody2D]:
	var flockmates: Array[RigidBody2D]
	for other_boid: RigidBody2D in flock:
		if (
			boid == other_boid ||
			boid.global_position.distance_to(other_boid.global_position) > perception
		):
			continue
		flockmates.append(other_boid)
	return flockmates

extends Node
class_name BoidMovementBehaviour
# abstract class used in movement manager to call behaviours
# made with incorrect assumption that manager would need to reset velocity every frame
# possible refactor would remove this class and have each behaviour apply velocity directly

func boid_velocity() -> Vector2:
	push_error("initialize() must be implemented in derived class")
	return Vector2.ZERO

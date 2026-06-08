extends BoidMovementBehaviour
class_name BoidSeek

@export var body: Node2D
@export var target: Node2D
@export var distance_to_strength: Curve

@onready var movement_manager: BoidMovementManager = get_parent()

func _ready() -> void:
	_enter_manager()

func _enter_manager() -> void:
	movement_manager.behaviours.append(self)

func boid_velocity() -> Vector2:
	var relative_position: Vector2 = target.global_position - body.global_position
	var strength: float = distance_to_strength.sample_baked(
		clampf(
			relative_position.length(),
			distance_to_strength.min_domain,
			distance_to_strength.max_domain
		)
	)
	
	return relative_position.normalized() * strength

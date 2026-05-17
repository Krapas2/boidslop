extends Node
class_name BossTargetTool

@export var velocity_by_distance: Curve
@export var steering_speed: float
@export var enabled: bool

@onready var body: RigidBody2D = get_parent()
@onready var target: Node2D = $Target

func _physics_process(delta: float) -> void:
	if !enabled:
		return
	
	var displacement: Vector2 = target.global_position - body.global_position
	var desired_direction: Vector2 = displacement.normalized()
	# Non-zero min_domain value would get clamped, in that case a radius around the target would set desired_speed to min_value.
	# This can be used to stop body when inside radius instead of only when position is exactly that of target,
	# or to create a bounce effect where body 'orbits' target
	var desired_speed: float = velocity_by_distance.sample_baked(
		clampf(
			displacement.length(),
			velocity_by_distance.min_domain,
			velocity_by_distance.max_domain
		)
	)
	
	body.linear_velocity = lerp(
		desired_direction * desired_speed,
		body.linear_velocity,
		pow(.5, steering_speed * delta)
	)

extends Node
class_name BoidPopulator

@export var boid_scene: PackedScene
@export var flock_manager: BoidFlockManager
@export var bounds: Rect2
@export var count: int

func _ready() -> void:
	for _n: int in count:
		spawn_boid()

func spawn_boid() -> void:
	var boid_body: RigidBody2D = boid_scene.instantiate()
	add_child(boid_body)
	
	set_boid_manager(boid_body)
	set_boid_position(boid_body)
	set_boid_velocity(boid_body)

func set_boid_position(boid_body: RigidBody2D) -> void:
	var position: Vector2 = Vector2(
		randf_range(bounds.position.x, bounds.end.x),
		randf_range(bounds.position.y, bounds.end.y)
	)
	boid_body.global_position = position
	
func set_boid_velocity(boid_body: RigidBody2D) -> void:
	var angle: float = randf_range(0, 2*PI)
	boid_body.linear_velocity = Vector2(cos(angle), sin(angle)) * 150
	
func set_boid_manager(boid_body: RigidBody2D) -> void:
	var movement_manager: BoidMovementManager = boid_body.get_node("BoidMovementManager")
	movement_manager.flock_manager = flock_manager

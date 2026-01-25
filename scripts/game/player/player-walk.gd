extends Node
class_name PlayerWalk

@export var speed: float
@export var acceleration: float

@onready var body: RigidBody2D = get_parent()

var direction: Vector2

func _physics_process(delta: float) -> void:
	direction = Vector2(
		Input.get_axis("walk_left", "walk_right"),
		Input.get_axis("walk_up", "walk_down")
	)
	
	body.linear_velocity = lerp(
		direction * speed,
		body.linear_velocity,
		pow(.5, acceleration * delta)
	)

extends Node
class_name PlayerBodyAnimationController

@export var physics_body: RigidBody2D
@export var swim_threshold: float

@onready var player: AnimationPlayer = get_parent()

func _process(_delta: float) -> void:
	player.play(_animation_to_play())

func _animation_to_play() -> String:
	if physics_body.linear_velocity.length() > swim_threshold:
		return "swim"
	return "idle"

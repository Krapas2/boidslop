extends Node
class_name PointForward

@onready var body: RigidBody2D = get_parent()

func _physics_process(_delta: float) -> void:
	var heading_angle: float = atan2(body.linear_velocity.x, -body.linear_velocity.y)
	body.rotation = heading_angle

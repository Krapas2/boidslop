extends Node
class_name PlayerLaunch

@export var origin: Node2D
@export var net: PackedScene
@export var launch_speed: float

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("shoot"):
		shoot()

func shoot() -> void:
	var mouse_position: Vector2 = get_viewport().get_mouse_position()
	var canvas_transform: Transform2D = get_viewport().get_canvas_transform()
	var global_mouse_pos: Vector2 = canvas_transform.affine_inverse() * mouse_position
	var net_body: RigidBody2D = net.instantiate()
	add_child(net_body)
	
	net_body.global_position = origin.global_position
	net_body.look_at(global_mouse_pos)
	net_body.linear_velocity = net_body.transform.x * launch_speed

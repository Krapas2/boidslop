extends Node
class_name PlayerLaunch

@export var origin: Node2D
@export var net: PackedScene
@export var charge_time: float
@export var min_launch_speed: float
@export var max_launch_speed: float

@onready var charge: float = 0

func _process(delta: float) -> void:
	if Input.is_action_pressed("shoot") && charge < charge_time:
		charge += delta

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_released("shoot"):
		shoot()
		charge = 0;

func shoot() -> void:
	var mouse_position: Vector2 = get_viewport().get_mouse_position()
	var canvas_transform: Transform2D = get_viewport().get_canvas_transform()
	var global_mouse_pos: Vector2 = canvas_transform.affine_inverse() * mouse_position
	var net_body: RigidBody2D = net.instantiate()
	add_child(net_body)
	
	net_body.global_position = origin.global_position
	net_body.look_at(global_mouse_pos)
	net_body.linear_velocity = net_body.transform.x * charged_speed()

func charged_speed() -> float:
	return remap(charge, 0, charge_time, min_launch_speed, max_launch_speed)

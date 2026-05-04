extends Node
class_name PlayerLaunch

@export var origin: Node2D
@export var net: PackedScene
@export var charge_time: float
@export var min_launch_speed: float
@export var max_launch_speed: float

@onready var charge: float = 0
@onready var full_charge_sound: AudioStreamPlayer2D = $FullChargePlayer
@onready var launch_player_sound: AudioStreamPlayer2D = $LaunchPlayer
@onready var full_charge_sound_played: bool = false

func _process(delta: float) -> void:
	if Input.is_action_pressed("shoot") && charge < charge_time:
		charge += delta
	elif charge >= charge_time && !full_charge_sound_played:
		full_charge_sound.play()
		full_charge_sound_played = true

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_released("shoot"):
		shoot()
		shoot_sound()
		charge = 0;
		full_charge_sound_played = false

func shoot() -> void:
	var mouse_position: Vector2 = get_viewport().get_mouse_position()
	var canvas_transform: Transform2D = get_viewport().get_canvas_transform()
	var global_mouse_pos: Vector2 = canvas_transform.affine_inverse() * mouse_position
	var net_body: RigidBody2D = net.instantiate()
	add_child(net_body)
	
	net_body.global_position = origin.global_position
	net_body.look_at(global_mouse_pos)
	net_body.linear_velocity = net_body.transform.x * charged_speed()

func shoot_sound() -> void:
	launch_player_sound.volume_linear = charge / charge_time
	launch_player_sound.play()

func charged_speed() -> float:
	return remap(charge, 0, charge_time, min_launch_speed, max_launch_speed)

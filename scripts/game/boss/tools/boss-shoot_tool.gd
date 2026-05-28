extends Node
class_name BossShootTool

@export var origin: Node2D
@export var projectile: PackedScene
@export var shoot_speed: float

@onready var cooldown: Timer = $Cooldown

func try_shoot(target_position: Vector2) -> void:
	var cooling_down: bool = cooldown.time_left > 0
	if cooling_down:
		return
	
	var projectile_body: RigidBody2D = projectile.instantiate()
	add_child(projectile_body)
	
	projectile_body.global_position = origin.global_position
	projectile_body.look_at(target_position)
	projectile_body.linear_velocity = projectile_body.transform.x * shoot_speed
	
	cooldown.start()

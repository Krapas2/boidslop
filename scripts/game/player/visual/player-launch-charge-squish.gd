extends Node
class_name PlayerLaunchChargeSquish

@export var squish_power: float
@export var squised_sprite: Node2D

@onready var player_launch: PlayerLaunch = get_parent()

func _process(_delta: float) -> void:
	squised_sprite.scale.x = _calculated_squish()
	
func _calculated_squish() -> float:
	return remap(
		player_launch.charge,
		0,
		player_launch.charge_time,
		1,
		squish_power
	)

extends ColorRect
class_name  PlayerHealthGUI

@export var player_health: Health
@export var lerp_speed: float
@export var health_curve_exponent: float

var normalized_health: float

func _ready() -> void:
	normalized_health = 1.

func _process(delta: float) -> void:
	if player_health && player_health.current_health > 0:
		normalized_health = pow(
			player_health.current_health / player_health.max_health,
			health_curve_exponent
		)
	else:
		normalized_health += (1. - normalized_health) * lerp_speed * delta
	
	material.set_shader_parameter("normalized_health", normalized_health)

extends ColorRect
class_name  PlayerHealthGUI

@export var player_health: Health
@export var lerp_speed: float
@export var health_curve_exponent: float

var normalized_health: float

func _ready() -> void:
	normalized_health = 1.

func _process(delta: float) -> void:
	var desired_value: float
	if player_health:
		desired_value = pow(
			player_health.current_health / player_health.max_health,
			health_curve_exponent
		)
	else:
		desired_value = 1.
	
	normalized_health = lerp(
		desired_value,
		normalized_health,
		pow(.5, lerp_speed * delta)
	)
	material.set_shader_parameter("normalized_health", normalized_health)

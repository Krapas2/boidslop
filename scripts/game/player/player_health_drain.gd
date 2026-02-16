extends Node
class_name PlayerHealthDrain

@export var health_drain: float

@onready var player_health: Health = get_parent()

func _process(delta: float) -> void:
	drain_health(delta)
	pass

func drain_health(delta: float) -> void:
	player_health.damage(health_drain * delta, false)

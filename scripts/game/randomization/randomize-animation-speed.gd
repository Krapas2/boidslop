extends Node
class_name RandomizeAnimationSpeed

@export var min_speed: float
@export var max_speed: float
@onready var sprite: AnimatedSprite2D = get_parent()

func _ready() -> void:
	sprite.speed_scale = randf_range(min_speed, max_speed)

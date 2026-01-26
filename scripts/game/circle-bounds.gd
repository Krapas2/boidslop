extends Node
class_name CircleBounds

@export var center: Vector2
@export var radius: float

@onready var body: Node2D = get_parent()

func _physics_process(_delta: float) -> void:
	if body.global_position.distance_to(center) > radius:
		body.global_position = body.global_position.normalized() * -radius

extends Node
class_name RandomizeRigidbodyScale

@export var min_scale: float
@export var max_scale: float
@onready var parent: Node2D = get_parent()

func _ready() -> void:
	call_deferred("_apply_scale")

func _apply_scale() -> void:
	var random_scale: float = randf_range(min_scale, max_scale)
	for child: Node in parent.get_children():
		if child is Node2D:
			child.scale *= Vector2.ONE * random_scale

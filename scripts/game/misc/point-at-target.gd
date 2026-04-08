extends Node
class_name PointAtTarget

@export var target: Node2D

@onready var body: Node2D = get_parent()

func _process(_delta: float) -> void:
	if target:
		body.look_at(target.global_position)

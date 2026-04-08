extends Node
class_name SquareBounds

@export var bounds: Rect2

@onready var body: Node2D = get_parent()

func _physics_process(_delta: float) -> void:
	if body.global_position.x > bounds.end.x:
		body.global_position.x = bounds.position.x
	elif body.global_position.x < bounds.position.x:
		body.global_position.x = bounds.end.x
		
	if body.global_position.y > bounds.end.y:
		body.global_position.y = bounds.position.y
	elif body.global_position.y < bounds.position.y:
		body.global_position.y = bounds.end.y

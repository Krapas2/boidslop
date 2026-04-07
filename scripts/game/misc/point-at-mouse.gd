extends Node
class_name PointAtMouse

@onready var body: Node2D = get_parent()

func _process(_delta: float) -> void:
	body.look_at(body.get_global_mouse_position())

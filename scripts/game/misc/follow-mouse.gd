extends Node
class_name FollowMouse

@onready var body: Node2D = get_parent()

func _process(_delta: float) -> void:
	body.global_position = body.get_global_mouse_position()

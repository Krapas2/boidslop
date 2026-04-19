extends Node
class_name DamageBehaviour

func damage_behaviour() -> void:
	push_error("damage_behaviour() must be implemented in derived class")
	await get_tree().process_frame

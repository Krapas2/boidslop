extends Node
class_name DeathBehaviour

func death_behaviour() -> void:
	push_error("death_behaviour() must be implemented in derived class")
	await get_tree().process_frame

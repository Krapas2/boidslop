extends DeathBehaviour
class_name DestroyNodeDeathBehaviour

@export var node_to_destroy: Node

func death_behaviour() -> void:
	node_to_destroy.queue_free()

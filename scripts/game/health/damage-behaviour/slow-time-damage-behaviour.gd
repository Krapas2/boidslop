extends DamageBehaviour
class_name SlowTimeDamageBehaviour

@export var duration: float = 0.5
@export var time_scale: float = 0.0

# TODO: time has once stayed slow after player died, figure out how big of a deal that is
func damage_behaviour() -> void:
	var original_time_scale: float = Engine.time_scale
	Engine.time_scale = time_scale

	await get_tree().create_timer(duration, true, false, true).timeout

	Engine.time_scale = original_time_scale

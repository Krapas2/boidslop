extends Node
class_name BossBehaviourManager

var behaviours: Array[BossBehaviour]
var active_behaviour: BossBehaviour

func _ready() -> void:
	behaviour_routine()

func behaviour_routine() -> void:
	while true:
		active_behaviour = highest_priority_behaviour()
		pick_behaviour(active_behaviour)
		
		var timer: Timer = active_behaviour.get_node("Length")
		timer.start()
		await timer.timeout

func pick_behaviour(behaviour_to_enable: BossBehaviour) -> void:
	for behaviour: BossBehaviour in behaviours:
		behaviour.enabled = false
	behaviour_to_enable.enabled = true

func highest_priority_behaviour() -> BossBehaviour:
	var highest_behaviour: BossBehaviour = null
	var highest_priority: float = -INF
	for behaviour: BossBehaviour in behaviours:
		var priority: float = behaviour.priority()
		if priority > highest_priority:
			highest_priority = priority
			highest_behaviour = behaviour
	return highest_behaviour

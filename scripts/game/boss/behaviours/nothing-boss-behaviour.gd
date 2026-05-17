extends BossBehaviour
class_name NothingBossBehaviour

@export var boss_object_manager: BossObjectManager
@export_group("Priority")
@export var base_priority: float

func priority() -> float:
	return base_priority

func setup() -> void:
	boss_object_manager.head_toolset.disable_all()
	boss_object_manager.head_toolset.idle_tool.enabled = true
	
	for hand_toolset: BossToolset in boss_object_manager.hand_toolsets:
		hand_toolset.disable_all()
		hand_toolset.idle_tool.enabled = true

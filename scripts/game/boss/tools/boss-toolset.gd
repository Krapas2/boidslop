extends Node
class_name BossToolset

@onready var idle_tool: BossIdleTool = \
	get_parent().get_node(BossToolNames.BOSS_IDLE_TOOL_NAME)
@onready var point_forward_tool: BossPointForwardTool = \
	get_parent().get_node(BossToolNames.BOSS_POINT_FORWARD_TOOL_NAME)
@onready var target_tool: BossTargetTool = \
	get_parent().get_node(BossToolNames.BOSS_TARGET_TOOL_NAME)
@onready var shoot_tool: BossShootTool = \
	get_parent().get_node(BossToolNames.BOSS_SHOOT_TOOL_NAME)

func disable_all() -> void:
	idle_tool.enabled = false
	point_forward_tool.enabled = false
	target_tool.enabled = false

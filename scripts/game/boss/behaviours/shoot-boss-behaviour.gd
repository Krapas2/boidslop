extends BossBehaviour
class_name ShootBossBehaviour

@export var player_body: RigidBody2D
@export var boss_object_manager: BossObjectManager

@export_group("Head Behaviour")
@export var head_target_position: Node2D
@export var head_roll_distance_unit: float
@export_group("Hand Behaviour")
@export var hand_velocity_by_distance: Curve
@export var hand_steering_speed: float
@export var hand_target_distance_to_reset: float
@export_group("Priority")
@export var time_since_picked_factor: float

@onready var time_between_hand_movement: Timer = $HandFollowTimer
@onready var moving_hand_index: int = 0
@onready var time_since_picked: float = 0

func priority() -> float:
	return time_since_picked * time_since_picked_factor

func _process(delta: float) -> void:
	time_since_picked += delta

func setup() -> void:
	time_since_picked = 0
	setup_head()
	for hand_toolset: BossToolset in boss_object_manager.hand_toolsets:
		setup_hand(hand_toolset)

func setup_head() -> void:
	var target_tool: BossTargetTool = boss_object_manager.head_toolset.target_tool
	boss_object_manager.head_toolset.disable_all()
	target_tool.enabled = true
	target_tool.target.global_position = head_target_position.global_position

func setup_hand(hand_toolset: BossToolset) -> void:
	var target_tool: BossTargetTool = hand_toolset.target_tool
	
	hand_toolset.disable_all()
	target_tool.enabled = true
	target_tool.velocity_by_distance = hand_velocity_by_distance
	target_tool.steering_speed = hand_steering_speed
	target_tool.target.global_position = target_tool.body.global_position

func _physics_process(_delta: float) -> void:
	if !enabled:
		return
	
	_head_behaviour()
	for hand_index: int in range(boss_object_manager.hand_toolsets.size()):
		_hand_behaviour(hand_index)

func _head_behaviour() -> void:
	_head_roll()
	_head_shoot()

func _head_roll() -> void:
	var head_body: RigidBody2D = boss_object_manager.head_toolset.target_tool.body
	var horizontal_distance: float = \
		head_body.global_position.x - \
		player_body.global_position.x
	
	head_body.rotation = atan(horizontal_distance / head_roll_distance_unit) 

func _head_shoot() -> void:
	boss_object_manager.head_toolset.shoot_tool.try_shoot(player_body.global_position)

func _hand_behaviour(hand_index: int) -> void:
	if hand_index == moving_hand_index:
		_hand_movement(hand_index)
	else:
		_hand_shoot(hand_index)

func _hand_shoot(hand_index: int) -> void:
	var hand_toolset: BossToolset = boss_object_manager.hand_toolsets[hand_index]
	var hand_body: RigidBody2D = hand_toolset.target_tool.body
	
	hand_toolset.shoot_tool.try_shoot(player_body.global_position)
	hand_body.look_at(player_body.global_position)

func _hand_movement(hand_index: int) -> void:
	var hand_toolset: BossToolset = boss_object_manager.hand_toolsets[hand_index]
	if !_hand_reached_target(hand_toolset.target_tool) || time_between_hand_movement.time_left > 0:
		return
	
	_advance_moving_hand(hand_toolset)

func _advance_moving_hand(current_toolset: BossToolset) -> void:
	var next_index: int = (moving_hand_index + 1) % boss_object_manager.hand_toolsets.size()
	var next_toolset: BossToolset = boss_object_manager.hand_toolsets[next_index]
	
	current_toolset.point_forward_tool.enabled = false
	next_toolset.point_forward_tool.enabled = true
	next_toolset.target_tool.target.global_position = _new_target_pos()
	
	moving_hand_index = next_index
	time_between_hand_movement.start()

func _new_target_pos() -> Vector2:
	return player_body.global_position

func _hand_reached_target(hand_target_tool: BossTargetTool) -> bool:
	var hand_body: RigidBody2D = hand_target_tool.body
	var distance_to_target: float = hand_body.global_position.distance_to(
		hand_target_tool.target.global_position
	)
	return distance_to_target <= hand_target_distance_to_reset

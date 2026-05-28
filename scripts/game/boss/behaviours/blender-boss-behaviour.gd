extends BossBehaviour
class_name BlenderBossBehaviour

@export var boss_object_manager: BossObjectManager

@export_group("Behaviour")
@export var velocity_by_distance: Curve
@export var steering_speed: float
@export var boid_samples: Array[CircleShape2D]
@export var center: Vector2
@export var radius: float
@export var delta_angle: float

@export_group("Priority")
@export var sample_areas: Array[Area2D]
@export var deviation_multiplier: float

var angle: float = 0

func priority() -> float:
	var samples: Array[float] = get_samples()
	return deviation_multiplier * get_stardard_deviation(samples)
	
func get_samples() -> Array[float]:
	var result: Array[float] = []
	for sample_area: Area2D in sample_areas:
		result.append(float(sample_area.get_overlapping_bodies().size()))
	return result
	
func get_stardard_deviation(values: Array[float]) -> float:
	var average: float = FloatUtils.get_average(values)
	var deviations: Array[float] = []
	for value: int in values:
		deviations.append(pow(value-average, 2))
	var variance: float = FloatUtils.get_average(deviations)
	
	return sqrt(variance)

func setup() -> void:
	boss_object_manager.head_toolset.disable_all()
	boss_object_manager.head_toolset.idle_tool.enabled = true
	for hand_toolset: BossToolset in boss_object_manager.hand_toolsets:
		hand_setup(hand_toolset)

func hand_setup(hand_toolset: BossToolset) -> void:
	var target_tool: BossTargetTool = hand_toolset.target_tool
	
	hand_toolset.disable_all()
	hand_toolset.target_tool.enabled = true
	target_tool.velocity_by_distance = velocity_by_distance
	target_tool.steering_speed = steering_speed
	hand_toolset.point_forward_tool.enabled = true

func _physics_process(delta: float) -> void:
	if enabled:
		spin_hands(delta)

func spin_hands(delta: float) -> void:
	move_hands()
	angle_step(delta)

func move_hands() -> void:
	for i: int in range(boss_object_manager.hand_toolsets.size()):
		var hand_angle: float = angle+(2*PI/boss_object_manager.hand_toolsets.size())*i
		var desired_position: Vector2 = Vector2(
			cos(hand_angle),
			sin(hand_angle),
		) * radius + center
		var hand_toolset: BossToolset = boss_object_manager.hand_toolsets[i]
		hand_toolset.target_tool.target.global_position = desired_position

func angle_step(delta_time: float) -> void:
	angle = fmod(angle+delta_angle * delta_time, 2*PI)

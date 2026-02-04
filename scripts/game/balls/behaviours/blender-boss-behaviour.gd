extends BossBehaviour
class_name BlenderBossBehaviour

@export_group("Behaviour")
@export var hands: Array[RigidBody2D]
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
	var average: float = get_average(values)
	var deviations: Array[float] = []
	for value: int in values:
		deviations.append(pow(value-average, 2))
	var variance = get_average(deviations)
	
	return sqrt(variance)
	
func get_average(values: Array[float]) -> float:
	var sum: float = 0
	for value: int in values:
		sum += value
	return sum/values.size()

func _physics_process(delta: float) -> void:
	#print("blender priority: ", priority())
	if enabled:
		spin_hands(delta)
	
func spin_hands(delta: float) -> void:
	move_hands()
	angle_step(delta)

func move_hands() -> void:
	for i in range(hands.size()):
		var hand_angle: float = angle+(2*PI/hands.size())*i
		var desired_position: Vector2 = Vector2(
			cos(hand_angle),
			sin(hand_angle),
		) * radius + center
		hands[i].global_position = desired_position
		hands[i].rotation = hand_angle+PI

func angle_step(delta_time: float) -> void:
	angle = fmod(angle+delta_angle * delta_time, 2*PI)

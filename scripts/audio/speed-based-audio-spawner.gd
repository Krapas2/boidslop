extends Node
class_name SpeedBasedAudioSpawner

@export var speed_to_cooldown_curve: Curve
@export var min_speed: float
@export var audio_player: PackedScene

@onready var body: RigidBody2D = get_parent()
@onready var cooldown: Timer = $CooldownTimer

func _physics_process(_delta: float) -> void:
	if body.linear_velocity.length() < min_speed:
		return
	
	var cooling_down: bool = cooldown.time_left > 0
	if !cooling_down:
		_spawn_audio_player()
		cooldown.wait_time = _get_cooldown_length()
		cooldown.start()

func _get_cooldown_length() -> float:
	return speed_to_cooldown_curve.sample_baked(body.linear_velocity.length())

func _spawn_audio_player() -> void:
	var spawned_audio_player: Variant = audio_player.instantiate()
	add_child(spawned_audio_player)

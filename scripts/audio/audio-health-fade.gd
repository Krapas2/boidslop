extends Node
class_name AudioHealthFade

@export var map: Curve

@onready var health: Health = get_parent()
@onready var audio: AudioStreamPlayer = $AudioStreamPlayer

func _process(_delta: float) -> void:
	var normalized_health: float = clamp(health.current_health / health.max_health,0,1)
	audio.volume_linear = map.sample_baked(normalized_health)

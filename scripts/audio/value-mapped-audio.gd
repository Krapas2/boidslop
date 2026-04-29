extends Node
class_name ValueMappedAudio

@export var map: Curve
@export var source_property: String
@export var max_property: String

@onready var source_node: Node = get_parent()
@onready var audio: AudioStreamPlayer = $AudioStreamPlayer

# volume control does not kick in until scene is initialized.
# desired volume for when the scene is loading needs to be set in inspector
#TODO: find a way to set default value instead of changing it by hand
func _process(_delta: float) -> void:
	var value: float = source_node.get(source_property)
	var max_value: float = source_node.get(max_property)
	var normalized_value: float = clamp(value / max_value, 0.0, 1.0)
	
	audio.volume_linear = map.sample_baked(normalized_value)

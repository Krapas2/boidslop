extends Node
class_name DestroyOnAudioEnd

@onready var audio_player: Variant = get_parent()

func _ready() -> void:
	audio_player.finished.connect(_destroy_self)
	
func _destroy_self() -> void:
	audio_player.queue_free()

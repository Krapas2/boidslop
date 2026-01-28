extends Node
class_name RandomizeAnimationStart

@onready var sprite: AnimatedSprite2D = get_parent()

func _ready():
	sprite.play()
	sprite.frame = randi() % sprite.sprite_frames.get_frame_count(sprite.animation)

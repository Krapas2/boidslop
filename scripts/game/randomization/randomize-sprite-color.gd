extends Node
class_name RandomizeSpriteColor

@export_color_no_alpha var base_color: Color
@export var hue_shift_range: float
@export var saturation_range: float
@export var value_range: float
@export var apply_to_children: bool = false

@onready var parent: Node = get_parent()

func _ready() -> void:
	if !(parent is Sprite2D or parent is AnimatedSprite2D):
		push_error("color randomization needs to be applied to sprite or animatedsprite")
	
	_apply_color()

func _apply_color() -> void:
	var color_modulation: Color = _get_random_color()
	
	parent.modulate = color_modulation

func _get_random_color() -> Color:
	var hue_shift: float = randf_range(-hue_shift_range, hue_shift_range)
	var sat_mult: float = randf_range(-saturation_range, saturation_range)
	var val_mult: float = randf_range(-value_range, value_range)
	
	var hsv_color: Color = Color.from_hsv(
		fmod(base_color.h + hue_shift, 1.0),
		clamp(base_color.s + sat_mult, 0.0, 1.0),
		clamp(base_color.v + val_mult, 0.0, 1.0),
		base_color.a
	)
	
	return hsv_color

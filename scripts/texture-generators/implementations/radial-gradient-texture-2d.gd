@tool
class_name RadialGradientTexture2D
extends UvTextureGenerator2D

@export var gradient: Gradient

func _should_generate() -> bool:
	return gradient != null

func _pixel_from_uv(uv: Vector2) -> Color:
	var dist: float = uv.distance_to(Vector2(0.5, 0.5)) * 2.0
	var t: float = clampf(dist, 0.0, 1.0)
	return gradient.sample(t)

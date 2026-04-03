@tool
class_name RadialGradientTexture2D
extends UvTextureGenerator2D

@export var center_color: Color
@export var edge_color: Color
@export_range(0.1, 10.0) var attenuation: float

func _should_generate() -> bool:
	return attenuation > 0.0

func _pixel_from_uv(uv: Vector2) -> Color:
	var dist: float = uv.distance_to(Vector2(0.5, 0.5)) * 2.0
	var t: float = pow(clampf(dist, 0.0, 1.0), attenuation)
	return center_color.lerp(edge_color, t)

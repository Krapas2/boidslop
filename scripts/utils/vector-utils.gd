class_name VectorUtils

static func clamp_magnitude_v2(v: Vector2, max_length: float) -> Vector2:
	if v.length() > max_length:
		return v.normalized() * max_length
	return v

static func clamp_magnitude_v3(v: Vector3, max_length: float) -> Vector3:
	if v.length() > max_length:
		return v.normalized() * max_length
	return v

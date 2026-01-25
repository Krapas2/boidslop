class_name VectorUtils

static func clamp_magnitude(v, max_length: float):
	if v is Vector2:
		if v.length() > max_length:
			return v.normalized() * max_length
		return v
	
	if v is Vector3:
		if v.length() > max_length:
			return v.normalized() * max_length
		return v
	
	push_error("clamp_magnitude only supports Vector2 or Vector3")
	return v

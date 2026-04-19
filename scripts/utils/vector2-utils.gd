class_name Vector2Utils

static func get_average(values: Array[Vector2]) -> Vector2:
	if values.is_empty():
		return Vector2.ZERO
	var sum: Vector2 = Vector2.ZERO
	for value: Vector2 in values:
		sum += value
	return sum/values.size()

static func clamp_magnitude(v: Vector2, min_length: float, max_length: float) -> Vector2:
	if v.length() < min_length:
		return v.normalized() * min_length
	if v.length() > max_length:
		return v.normalized() * max_length
	return v

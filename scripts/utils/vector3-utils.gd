class_name Vector3Utils

static func get_average(values: Array[Vector3]) -> Vector3:
	if values.is_empty():
		return Vector3.ZERO
	var sum: Vector3 = Vector3.ZERO
	for value: Vector3 in values:
		sum += value
	return sum/values.size()

static func clamp_magnitude(v: Vector3, min_length: float, max_length: float) -> Vector3:
	if v.length() < min_length:
		return v.normalized() * min_length
	if v.length() > max_length:
		return v.normalized() * max_length
	return v

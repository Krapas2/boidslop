class_name FloatUtils

static func get_average(values: Array[float]) -> float:
	if values.is_empty():
		return 0
	var sum: float = 0
	for value: int in values:
		sum += value
	return sum/values.size()

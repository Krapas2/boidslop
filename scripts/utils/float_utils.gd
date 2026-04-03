class_name FloatUtils

static func get_average(values: Array[float]) -> float:
	var sum: float = 0
	for value: int in values:
		sum += value
	return sum/values.size()

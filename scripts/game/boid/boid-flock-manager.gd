extends Node
class_name BoidFlockManager

@export var chunk_size: float
var flock: Array[RigidBody2D]

var chunks: Dictionary[Vector2i, Array]

func _process(_delta: float) -> void:
	get_chunks()

func get_chunks() -> void:
	chunks = chunk_map()

func get_flockmates(boid: Node2D, perception: float) -> Array[RigidBody2D]:
	var relevant_flock: Array[RigidBody2D]
	var node_chunk: Vector2i = chunk_from_position(boid.global_position)
	
	for x in range(-1, 2):
		for y in range(-1, 2):
			var relevant_chunk: Vector2i = node_chunk + Vector2i(x, y)
			if chunks.has(relevant_chunk):
				relevant_flock.append_array(chunks[relevant_chunk])
	
	var flockmates: Array[RigidBody2D]
	for other_boid: RigidBody2D in relevant_flock:
		if (
			boid == other_boid ||
			boid.global_position.distance_to(other_boid.global_position) > perception
		):
			continue
		flockmates.append(other_boid)
	return flockmates


func chunk_map() -> Dictionary[Vector2i, Array]:
	var map: Dictionary[Vector2i, Array] = {}
	
	for boid in flock:
		var chunk: Vector2i = chunk_from_position(boid.global_position)
		if not map.has(chunk):
			map[chunk] = []
		map[chunk].append(boid)
	
	return map

func chunk_from_position(position: Vector2) -> Vector2i:
	return (position/chunk_size).floor();

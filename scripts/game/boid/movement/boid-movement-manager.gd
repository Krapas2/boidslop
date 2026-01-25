extends Node
class_name BoidMovementManager

@export var flock_manager: BoidFlockManager:
	set(value):
		flock_manager = value
		if is_inside_tree():
			_enter_manager()

@onready var body: RigidBody2D = get_parent()

var behaviours: Array[BoidMovementBehaviour]

func _ready() -> void:
	if !!flock_manager:
		_enter_manager()

func _enter_manager() -> void: 
	flock_manager.flock.append(body)

func _physics_process(_delta: float) -> void:
	for behaviour: BoidMovementBehaviour in behaviours:
		body.linear_velocity += behaviour.boid_velocity()

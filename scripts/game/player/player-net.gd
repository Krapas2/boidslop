extends Node
class_name PlayerNetBehaviour

@export_group("Catching")
@export var catch_area: Area2D
@export var damping_factor: float
@export var growing_factor: float

@export_group("Picking")
@export var pick_area: Area2D
@export var health_per_body: float
@export var min_catch_speed: float

var bodies_consumed: int
var captured_bodies_offset: Vector2

@onready var net_body: RigidBody2D = get_parent()
@onready var initial_damping: float = net_body.linear_damp
@onready var initial_scale: Vector2 = net_body.scale
@onready var captured_bodies: Node2D = $CapturedBodies
@onready var pick_timer: Timer = $PickTimer

func _ready() -> void:
	captured_bodies_offset = Vector2.ZERO

func _physics_process(_delta: float) -> void:
	pick_behaviour()
	set_captured_position()
	consume_bodies()
	
	dampen()
	grow()

func pick_behaviour() -> void:
	var overlapping_bodies: Array[Node2D] = pick_area.get_overlapping_bodies()
	if !overlapping_bodies.size() || !can_be_picked():
		return
	
	var player_health: Health = overlapping_bodies[0].get_node("PlayerHealth")
	player_health.current_health += bodies_consumed * health_per_body
	net_body.queue_free()

func can_be_picked() -> bool:
	var net_is_spoiled: bool = net_body.linear_velocity.length() < min_catch_speed
	var newly_spawned: bool = !pick_timer.is_stopped()
	
	return net_is_spoiled || !newly_spawned

func consume_bodies() -> void:
	var net_is_spoiled: bool = net_body.linear_velocity.length() < min_catch_speed
	if net_is_spoiled:
		return
	
	var overlapping_bodies: Array[Node2D] = catch_area.get_overlapping_bodies()
	for overlapping_body: RigidBody2D in overlapping_bodies:
		for child: Node in overlapping_body.get_children():
			if not child is AnimatedSprite2D:
				child.queue_free()
		overlapping_body.reparent(captured_bodies)
		overlapping_body.freeze = true
		
		set_captured_offset(overlapping_body.position)

		bodies_consumed += 1

func dampen() -> void:
	net_body.linear_damp = initial_damping + bodies_consumed * damping_factor

func grow() -> void:
	net_body.scale = initial_scale + Vector2.ONE * bodies_consumed * growing_factor

func set_captured_position() -> void:
	captured_bodies.global_position = net_body.global_position + captured_bodies_offset

func set_captured_offset(new_pos: Vector2) -> void:
	captured_bodies_offset = -(
		(-captured_bodies_offset * bodies_consumed + new_pos) /
		(bodies_consumed + 1)
	)

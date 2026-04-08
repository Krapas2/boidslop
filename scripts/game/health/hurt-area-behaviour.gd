extends Node
class_name HurtAreaBehaviour

@export var damage: float
@export var trigger_iframes: bool

@onready var area: Area2D = get_parent()

func _ready() -> void:
	area.body_entered.connect(_on_body_entered)
	area.area_entered.connect(_on_area_entered)

func _on_body_entered(body: Node) -> void:
	_try_damage(body)

func _on_area_entered(other_area: Area2D) -> void:
	_try_damage(other_area)

func _try_damage(target: Node) -> void:
	#TODO: find_node_in might be too slow, since player is the only object with health, a singleton might be best
	var health: Health = NodeUtils.find_node_in(target, Health) as Health
	if health:
		health.damage(damage, trigger_iframes)

extends Node
class_name Health

@export var max_health: float
@export var damage_behaviours: Array[DamageBehaviour]
@export var death_behaviours: Array[DeathBehaviour]

@onready var current_health: float = max_health:
	set(value):
		current_health = min(value, max_health)
var invincible: bool

@onready var invincibility_timer: Timer = $InvincibilityTimer

func _process(_delta: float) -> void:
	death_behaviour()

func death_behaviour() -> void:
	if current_health <= 0:
		for behaviour: DeathBehaviour in death_behaviours:
			await behaviour.death_behaviour()

func damage(amount: float, trigger_behaviours: bool) -> void:
	if invincible:
		return
		
	current_health -= amount
	if trigger_behaviours:
		damage_behaviour()
		invincibility_behaviour()

func invincibility_behaviour() -> void:
	invincible = true
	invincibility_timer.start()
	await invincibility_timer.timeout
	invincible = false

func damage_behaviour() -> void:
	for behaviour: DamageBehaviour in damage_behaviours:
		await behaviour.damage_behaviour()

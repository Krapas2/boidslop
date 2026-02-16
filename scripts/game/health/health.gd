extends Node
class_name Health

@export var max_health: float
@export var death_behaviours: Array[DeathBehaviour]

var current_health: float
var invincible: bool

@onready var invincibility_timer: Timer = $InvincibilityTimer

func _ready() -> void:
	current_health = max_health

func _process(_delta: float) -> void:
	death_behaviour()

func death_behaviour() -> void:
	if current_health <= 0:
		for behaviour: DeathBehaviour in death_behaviours:
			await behaviour.death_behaviour()

func damage(amount: float, trigger_iframes: bool) -> void:
	if invincible:
		return
		
	current_health -= amount
	if trigger_iframes:
		invincibility_behaviour()

func invincibility_behaviour() -> void:
	invincible = true
	invincibility_timer.start()
	await invincibility_timer.timeout
	invincible = false

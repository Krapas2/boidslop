extends Node
class_name BossBehaviour

@onready var manager: BossBehaviourManager = get_parent()

var enabled: bool

func _ready() -> void:
	enabled = false
	enter_manager()

func enter_manager() -> void: 
	manager.behaviours.append(self)

func priority() -> float:
	push_error("priority() must be implemented in derived class")
	return 0

func setup() -> void:
	push_error("setup() must be implemented in derived class")

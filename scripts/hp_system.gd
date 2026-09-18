extends Node
class_name health


signal health_changed(new_health: int, max_health: int)
signal damage_taken(amount: int, source: Node2D)
signal immortal_changed(new_imm: float, max_imm: float)
signal died()


@export var max_health: int = 10
@export var start_at_max: bool = true
@export var max_imm: float = 100
@export var start_at_max_imm: bool = true

var current_health: int
var current_imm: float
var is_alive: bool = true


func _ready() -> void:
	if start_at_max:
		current_health = max_health
	else:
		current_health = 0
	
	if start_at_max_imm:
		current_imm = max_imm
	else:
		current_imm = 0       


func take_damage(amount: int, source: Node2D = null) -> void:
	if not is_alive:
		return

	var actual_damage = max(0, amount)
	current_health = max(0, current_health - actual_damage)

	damage_taken.emit(actual_damage, source)
	health_changed.emit(current_health, max_health)

	print(get_parent().name, " took ", actual_damage, " damage. Health: ", current_health, "/", max_health)

	if current_health <= 0:
		_handle_death()


func _handle_death() -> void:
	if not is_alive:
		return

	is_alive = false
	current_health = 0

	died.emit()


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("take_damage"):
		take_damage(1)

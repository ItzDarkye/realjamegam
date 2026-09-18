class_name Health
extends Node


signal max_health_changed(diff: int)
signal health_changed(diff: int)
signal health_depleted


@export var max_health: int = 5 : set = set_max_health, get = get_max_health
@export var immortality: bool = false

var immortality_timer: Timer = null

@onready var health: int = max_health


func set_max_health(value: int):
  pass 

func get_max_health() -> int:
	return max_health

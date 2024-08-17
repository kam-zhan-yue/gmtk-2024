class_name Health
extends Area2D

@export var max_health := 100.0
var health := 0.0

signal on_dead

func init() -> void:
	health = max_health

func damage(amount: float) -> void:
	health -= amount
	if health <= 0:
		on_dead.emit()

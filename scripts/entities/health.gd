class_name Health
extends Area2D

@export var max_health := 100.0
var health := 0.0
var dead := false

signal on_damage(value:  float)
signal on_dead

func init() -> void:
	dead = false
	health = max_health

func damage(amount: float) -> void:
	#if dead:
		#return
	print(str('Took damage for ', amount, ' points!'))
	health -= amount
	on_damage.emit(amount)
	#if health <= 0:
		#dead = true
		#on_dead.emit()

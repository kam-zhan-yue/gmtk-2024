class_name Player
extends Node2D

@export var speed := 30.0
@onready var health := %Health as Health
@onready var anim := $AnimatedSprite2D as AnimatedSprite2D

signal on_damage(value: float)

func _ready() -> void:
	anim.play("diver_swim")
	health.init()
	health.on_damage.connect(_on_damage)
	health.on_dead.connect(_on_dead)

func _process(delta: float) -> void:
	global_position.y -= speed * delta

func _on_dead() -> void:
	print("Player is dead")

func damage(amount: float) -> void:
	health.damage(amount)

func _on_damage(value: float) -> void:
	on_damage.emit(value)

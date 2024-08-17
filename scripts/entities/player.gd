class_name Player
extends Node2D

@onready var health := %Health as Health

func _ready() -> void:
	health.init()
	health.on_dead.connect(_on_dead)

func _on_dead() -> void:
	print("Player is dead")

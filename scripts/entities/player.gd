class_name Player
extends Node2D

@onready var health := %Health as Health

func _ready() -> void:
	health.init()

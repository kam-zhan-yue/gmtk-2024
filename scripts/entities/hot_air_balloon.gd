class_name HotAirBalloon
extends AnimatedSprite2D

func _ready() -> void:
	play("idle")

func activate() -> void:
	play("activate")

func deactivate() -> void:
	play("idle")

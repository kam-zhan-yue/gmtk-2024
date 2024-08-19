class_name Fish
extends Enemy

@onready var fish_boid: Boid = $".."

func _ready() -> void:
	fish_boid.on_uninit.connect(release)

func _on_type_entity_on_complete() -> void:
	BoidManager.uninit(fish_boid)

class_name Fish
extends Enemy

@onready var fish_boid: Boid = $".."


func _on_type_entity_on_complete() -> void:
	BoidManager.uninit(fish_boid)

extends Node2D

var speed = 100.0

func _process(delta: float) -> void:
	var input_vector = Vector2(0, Input.get_axis("move_up", "move_down"))
	global_position += input_vector * speed * delta

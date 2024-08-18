class_name Bird
extends Enemy

@export var speed := 0.1
@onready var path_follow := $"." as PathFollow2D

func _process(delta: float) -> void:
	if path_follow:
		path_follow.progress_ratio += delta * speed

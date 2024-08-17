class_name Fish
extends Enemy

func _process(delta: float) -> void:
	if path_follow:
		path_follow.progress_ratio += delta * speed

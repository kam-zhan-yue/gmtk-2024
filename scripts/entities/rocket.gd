class_name Rocket
extends Enemy

@export var speed := 100.0

func _process(delta: float) -> void:
	if not game_state:
		return
	var player := game_state.player
	var direction := (player.global_position - global_position).normalized()
	global_position += direction * speed * delta

func _on_area_2d_area_entered(area: Area2D) -> void:
	if area is not Health:
		return
	var health = area as Health
	type_entity.on_complete.disconnect(_on_complete)
	health.damage(data.damage)
	queue_free()
	

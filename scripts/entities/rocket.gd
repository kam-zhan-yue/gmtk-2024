class_name Rocket
extends Enemy

@export var speed := 75.0
@onready var sprite_2d: Sprite2D = $Sprite2D

func _process(delta: float) -> void:
	if not game_state:
		return
	if completed: return
	var player := game_state.player
	var direction := (player.global_position - global_position).normalized()
	global_position += direction * speed * delta
	
	var angle := atan2(direction.y, direction.x)
	sprite_2d.rotation = angle

func _on_area_2d_area_entered(area: Area2D) -> void:
	if area is not Health:
		return
	var health = area as Health
	type_entity.on_complete.disconnect(_on_complete)
	health.damage(data.damage)
	completed = true
	fade_out()
	

func fade_out(fade_time := 0.2) -> void:
	sprite_2d.modulate.a = 1.0
	var timer := 0.0
	while timer < fade_time:
		var t := timer / fade_time
		sprite_2d.modulate.a = 1-t
		timer += get_process_delta_time()
		await Global.frame()
	sprite_2d.modulate.a = 0.0
	queue_free()

class_name Eagle
extends Enemy

@export var speed := 0.1
@export var swoop_speed := 300.0
@export var air_time := 5.0
@onready var path_follow := $"." as PathFollow2D
@onready var sprite_2d := $Sprite2D as Sprite2D

var last_position := Vector2.ZERO

func _ready() -> void:
	on_init.connect(_on_init)
	
func _on_init() -> void:
	await fly_async()
	await swoop_async()
	queue_free()

func fly_async() -> void:
	var timer := 0.0
	print("Fly")
	while timer < air_time:
		var delta := get_process_delta_time()
		timer += delta
		path_follow.progress_ratio += delta * speed
		check_flip()
		await Global.frame()

func swoop_async() -> void:
	print("Swoop")
	var start_pos := global_position
	var player_pos := game_state.player.global_position
	var direction := (player_pos - start_pos).normalized()
	var swoop_time := 5.0
	var timer := 0.0
	
	while timer < swoop_time:
		var delta := get_process_delta_time()
		global_position += direction * swoop_speed * delta
		timer += delta
		check_flip()
		await Global.frame()

func check_flip() -> void:
	if position.x < last_position.x:
		sprite_2d.flip_h = false
	else:
		sprite_2d.flip_h = true
	last_position = position


func _on_area_2d_area_entered(area: Area2D) -> void:
	if area is not Health:
		return
	var health = area as Health
	type_entity.on_complete.disconnect(_on_complete)
	health.damage(data.damage)
	queue_free()

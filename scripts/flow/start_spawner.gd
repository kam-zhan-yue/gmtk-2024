class_name StartSpawner
extends Node2D

const TIME_BETWEEN_SPAWNS = 5.0
var timer := 0.0
var spawning := false

func start_spawning() -> void:
	spawn()
	spawning = true
	timer = 0.0

func stop_spawning() -> void:
	spawning = false

func _process(delta: float) -> void:
	if not spawning:
		return
	timer += delta
	if timer > TIME_BETWEEN_SPAWNS:
		timer = 0.0
		spawn()

func spawn() -> void:
	for n in get_children():
		if n is BoidSpawner:
			(n as BoidSpawner).spawn()

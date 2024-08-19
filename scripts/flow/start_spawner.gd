class_name StartSpawner
extends Node2D

@onready var boid_spawner_1: BoidSpawner = $BoidSpawner1
@onready var boid_spawner_2: BoidSpawner = $BoidSpawner2

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
	boid_spawner_1.spawn()
	boid_spawner_2.spawn()

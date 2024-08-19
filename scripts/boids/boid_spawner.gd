class_name BoidSpawner
extends Node2D

@export var boid_scene: PackedScene
@export var start_direction := Vector2.UP
@export var spawn_radius := 100.0
@export var spawn_count := 50
@export var spawn_on_ready := true

func _ready() -> void:
	if not spawn_on_ready:
		return
	spawn()

func spawn() -> void:
	print("Spawn")
	for i in spawn_count:
		var angle := randf() * 2 * PI
		var radius := randf() * spawn_radius
		var spawn_point := Vector2(radius * cos(angle), radius * sin(angle))
		var boid := boid_scene.instantiate() as Boid
		add_child(boid)
		boid.global_position = global_position + spawn_point
		boid.direction = start_direction
		boid.init()

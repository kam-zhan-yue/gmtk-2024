class_name BoidSpawner
extends Node2D

@export_enum("Circle", "Path") var spawn_type := 0
@export_enum("Fish", "Tuna", "Bird", "Sparrow") var group := 0
@export var boid_scene: PackedScene
@export var start_direction := Vector2.UP
@export var spawn_radius := 100.0
@export var spawn_count := 50
@export var spawn_on_ready := true

@onready var path_follow := $Path2D/PathFollow2D as PathFollow2D

func _ready() -> void:
	if not spawn_on_ready:
		return
	spawn()

func spawn() -> void:
	if spawn_type == 0:
		spawn_circle()
	elif spawn_type == 1:
		spawn_path()

func spawn_path() -> void:
	var progress := 0.0
	var increments := 1.0 / spawn_count
	for i in spawn_count:
		path_follow.progress_ratio = progress
		progress += increments
		spawn_boid(path_follow.position)

func spawn_circle() -> void:
	for i in spawn_count:
		var angle := randf() * 2 * PI
		var radius := randf() * spawn_radius
		var spawn_point := Vector2(radius * cos(angle), radius * sin(angle))
		spawn_boid(spawn_point)

func spawn_boid(point: Vector2) -> void:
		var boid := boid_scene.instantiate() as Boid
		add_child(boid)
		boid.global_position = global_position + point
		boid.direction = start_direction
		boid.init(group)

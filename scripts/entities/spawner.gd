class_name Spawner
extends Node2D

const ENTITY = preload("res://scenes/type_entity.tscn")

const random = ["Apple Pie", "Tuna", "Oreo", "Broccoli"]

func _ready() -> void:
	spawn_async()
	pass

func spawn_async() -> void:
	while(true):
		var time = randf_range(0.2, 1.0)
		await Global.seconds(time)
		spawn()

func spawn() -> void:
	var entity = ENTITY.instantiate() as TypeEntity
	
	# Get the screen size
	var screen_size = get_viewport().get_visible_rect().size
	
	# Randomly assign the position within the screen bounds
	entity.position = Vector2(
		randf() * screen_size.x,  # Random x position
		randf() * screen_size.y   # Random y position
	)
	
	# Add the entity to the scene tree as a child of the current node
	add_child(entity)
	entity.init(random[randi_range(0, len(random)-1)])

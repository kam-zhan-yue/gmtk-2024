class_name SpawnConfig
extends Resource

@export var start_beat := 0
@export var end_beat := 100
@export var bpm := 100.0

const PREFIX = "res://scenes/spawn_groups/spawn_group_"

func beat() -> float:
	return 60 / bpm

func spawn(current_beat: int) -> SpawnGroup:
	var path := str(PREFIX, current_beat, ".tscn")
	if not ResourceLoader.exists(path):
		return
	var resource := load(path)
	if resource:
		var scene = resource.instantiate() as SpawnGroup
		print(str("Spawning: ", path, " Scene: ", scene))
		return scene
	return null

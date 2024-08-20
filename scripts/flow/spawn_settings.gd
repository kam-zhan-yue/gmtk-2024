class_name BeatSettings
extends Resource

@export var start_beat := 0
@export var end_beat := 100
@export var bpm := 100.0

func beat() -> float:
	return 60 / bpm

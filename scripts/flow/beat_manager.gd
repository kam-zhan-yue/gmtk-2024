extends Node2D

const CONFIG = preload("res://resources/spawn_settings.tres")

var beats := 0

signal on_beat(num: int)
var playing := false
var timer := 0.0
	
func start() -> void:
	timer = 0.0
	beats = CONFIG.start_beat
	playing = true

func stop() -> void:
	playing = false

func _process(delta: float) -> void:
	if not playing:
		return
	if beats > CONFIG.end_beat:
		return
	if timer > CONFIG.beat():
		timer = 0.0
		print(str("Beat: ", beats))
		on_beat.emit(beats)
		beats += 1
	timer += delta

func beats_to_seconds(beat: int) -> float:
	return beat * CONFIG.beat()

func get_start_beat() -> int:
	return CONFIG.start_beat

func get_end_beat() -> int:
	return CONFIG.end_beat

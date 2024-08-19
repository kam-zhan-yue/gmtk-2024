extends Node2D

const CONFIG = preload("res://resources/spawn_settings.tres")

var beats := 0

signal on_beat(num: int)
var playing := false
var timer := 0.0
	
func start() -> void:
	timer = 0.0
	beats = 0
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
		on_beat.emit(beats)
		beats += 1
		print(str("Beat: ", beats))
	timer += delta

func beats_to_seconds(beat: int) -> float:
	return beat * CONFIG.beat()

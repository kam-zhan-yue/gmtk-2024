class_name GameManager
extends Node


@onready var player := %Player as Player
@onready var ui := %UI as UI
@onready var start_spawner: StartSpawner = $StartSpawner
@onready var music_player := %MusicPlayer as AudioStreamPlayer2D
@onready var timeline: Timeline = %Timeline
@onready var spawn_groups: Node2D = %SpawnGroups

var game_state: GameState

func _ready() -> void:
	game_state = GameState.new(player)
	game_state.on_pause.connect(_on_pause)
	game_state.on_start.connect(_on_start)
	game_state.on_restart.connect(_on_restart)
	ui.init(game_state)
	timeline.init(game_state)
	for group in spawn_groups.get_children():
		if group is SpawnTrigger:
			(group as SpawnTrigger).init(game_state)
	start_spawner.start_spawning()

func _on_pause(value: bool) -> void:
	music_player.stream_paused = value

func _on_start() -> void:
	start_spawner.stop_spawning()
	await timeline.start_camera()
	var start_beat := BeatManager.get_start_beat()
	var start_second := BeatManager.beats_to_seconds(start_beat)
	music_player.play(start_second)
	timeline.start()
	BeatManager.start()

func _on_restart() -> void:
	music_player.stop()
	# Clear up references
	BeatManager.stop()
	BoidManager.restart()
	EntityManager.restart()
	await timeline.restart()
	
	game_state = GameState.new(player)
	game_state.on_pause.connect(_on_pause)
	game_state.on_start.connect(_on_start)
	game_state.on_restart.connect(_on_restart)
	ui.init(game_state)
	timeline.init(game_state)
	for group in spawn_groups.get_children():
		if group is SpawnTrigger:
			(group as SpawnTrigger).init(game_state)
	game_state.start()

class_name GameManager
extends Node

const SUBMARINE_BEAT = 50
const BALLOON_BEAT = 100

@onready var player := %Player as Player
@onready var spawner := %Spawner as Spawner
@onready var ui := %UI as UI
@onready var start_spawner: StartSpawner = $StartSpawner
@onready var music_player := %MusicPlayer as AudioStreamPlayer2D
@onready var timeline: Timeline = $Timeline

var game_state: GameState

func _ready() -> void:
	game_state = GameState.new(player)
	game_state.on_pause.connect(_on_pause)
	game_state.on_start.connect(_on_start)
	game_state.on_restart.connect(_on_restart)
	ui.init(game_state)
	timeline.init(game_state)
	spawner.init(game_state)
	start_spawner.start_spawning()

func _on_pause(value: bool) -> void:
	music_player.stream_paused = value

func _on_start() -> void:
	start_spawner.stop_spawning()
	music_player.play()
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
	spawner.init(game_state)
	game_state.start()

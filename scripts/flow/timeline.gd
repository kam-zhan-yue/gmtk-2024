class_name Timeline
extends Node

const SUBMARINE_BEAT = 50
const BALLOON_BEAT = 100

@onready var spawner := %Spawner as Spawner
@onready var camera_controller := %CameraController as CameraController
@onready var submarine := %Submarine as Marker2D
@onready var balloon := %HotAirBalloon as Marker2D
@onready var start_marker := %Start as Marker2D

var game_state: GameState

func init(state: GameState) -> void:
	game_state = state
	camera_controller.init(state)

func _ready() -> void:
	BeatManager.on_beat.connect(_on_beat)

func start() -> void:
	submarine_setup()
	game_state.player.start()

func _on_beat(beat: int) -> void:
	match(beat):
		SUBMARINE_BEAT:
			game_state.player.speed = 0.0
			camera_controller.lerp_to(submarine.global_position)
		BALLOON_BEAT:
			camera_controller.lerp_to(balloon.global_position)


func submarine_setup() -> void:
	game_state.player.global_position = start_marker.global_position
	camera_controller.follow()
	var difference := submarine.global_position - game_state.player.global_position
	var distance := difference.length()
	var beat_time := BeatManager.beats_to_seconds(SUBMARINE_BEAT)
	var target_speed := distance / beat_time
	game_state.player.speed = target_speed

func balloon_setup() -> void:
	var difference := balloon.global_position - game_state.player.global_position
	var distance := difference.length()
	var beat_time := BeatManager.beats_to_seconds(SUBMARINE_BEAT)
	var target_speed := distance / beat_time
	game_state.player.speed = target_speed

func restart() -> void:
	submarine_setup()
	game_state.player.start()

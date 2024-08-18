class_name GameManager
extends Node

const SUBMARINE_BEAT = 30
const BALLOON_BEAT = 100

@onready var player := %Player as Player
@onready var spawner := %Spawner as Spawner
@onready var camera_controller := $"../CameraController" as CameraController
@onready var submarine := %Submarine as Marker2D
@onready var balloon := %HotAirBalloon as Marker2D
@onready var ui := %UI as UI

var game_state: GameState

func _ready() -> void:
	game_state = GameState.new(player)
	camera_controller.init(game_state)
	spawner.init(game_state)
	ui.init(game_state)
	BeatManager.on_beat.connect(_on_beat)
	BeatManager.start()
	submarine_setup()

func submarine_setup() -> void:
	var difference = submarine.global_position - player.global_position
	var distance = difference.length()
	var beat_time = BeatManager.beats_to_seconds(SUBMARINE_BEAT)
	var target_speed = distance / beat_time
	player.speed = target_speed

func balloon_setup() -> void:
	var difference = balloon.global_position - player.global_position
	var distance = difference.length()
	var beat_time = BeatManager.beats_to_seconds(SUBMARINE_BEAT)
	var target_speed = distance / beat_time
	player.speed = target_speed

func _on_beat(beat: int) -> void:
	match(beat):
		SUBMARINE_BEAT:
			player.speed = 0.0
			camera_controller.lerp_to(submarine.global_position)
		BALLOON_BEAT:
			camera_controller.lerp_to(balloon.global_position)

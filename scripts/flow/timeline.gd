class_name Timeline
extends Node2D

const SUBMARINE_BEAT = 10
const DIVER_BEAT = 15
const BALLOON_BEAT = 100

@onready var spawner := %Spawner as Spawner
@onready var camera_controller := %CameraController as CameraController
@onready var submarine := %SubmarineMarker as Marker2D
@onready var balloon := %BalloonMarker as Marker2D
@onready var start_marker := %StartMarker as Marker2D
@onready var submarine_follow := %SubmarineFollow as PathFollow2D
@onready var diver_follow := %DiverFollow as PathFollow2D

var game_state: GameState

enum State { SUBMARINE, DIVER, WALKER, BALLOON }
var current_beat := 0
var playing = false

func init(state: GameState) -> void:
	game_state = state
	camera_controller.init(state)

func _ready() -> void:
	BeatManager.on_beat.connect(_on_beat)

func start() -> void:
	playing = true
	current_beat = BeatManager.get_start_beat()
	game_state.player.start()
	await submarine_async()
	await dive_async()

func submarine_async() -> void:
	if current_beat >= SUBMARINE_BEAT:
		return
	# Reparent the player to the submarine and start camera tracking
	game_state.player.reparent(submarine_follow)
	camera_controller.follow()
	
	# Lerp the submarine path
	await lerp_path(submarine_follow, SUBMARINE_BEAT)

func dive_async() -> void:
	if current_beat >= DIVER_BEAT:
		return
	# Reparent the player to the dive, and keep camera tracking
	game_state.player.reparent(diver_follow)
	
	# Lerp the diver path
	await lerp_path(diver_follow, DIVER_BEAT - SUBMARINE_BEAT)

func lerp_path(path_follow: PathFollow2D, beats: int) -> void:
	var start := float(current_beat) / beats
	var total_time := BeatManager.beats_to_seconds(beats)
	var  timer := start * total_time
	while timer < total_time and playing:
		var t := timer / total_time
		path_follow.progress_ratio = t
		timer += get_process_delta_time()
		await Global.frame()

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
	var beat_time := BeatManager.beats_to_seconds(SUBMARINE_BEAT+1)
	var target_speed := distance / beat_time
	game_state.player.speed = target_speed

func balloon_setup() -> void:
	var difference := balloon.global_position - game_state.player.global_position
	var distance := difference.length()
	var beat_time := BeatManager.beats_to_seconds(SUBMARINE_BEAT)
	var target_speed := distance / beat_time
	game_state.player.speed = target_speed

func restart() -> void:
	playing = false
	submarine_follow.progress_ratio = 0
	diver_follow.progress_ratio = 0
	await camera_controller.lerp_to(camera_controller.original_pos)

class_name Timeline
extends Node2D

const SUBMARINE_BEAT = 70
const DIVER_BEAT = 80
const WALKER_BEAT = 85
const BALLOON_BEAT = 156
const WALKER_2_BEAT = 162
const SPACESHIP_BEAT = 200

@onready var spawner := %Spawner as Spawner
@onready var camera_controller := %CameraController as CameraController

@onready var submarine := %SubmarineMarker as Marker2D
@onready var balloon := %BalloonMarker as Marker2D
@onready var start_marker := %StartMarker as Marker2D
@onready var spaceship_marker := %SpaceshipMarker as Marker2D

@onready var submarine_follow := %SubmarineFollow as PathFollow2D
@onready var diver_follow := %DiverFollow as PathFollow2D
@onready var walker_follow := %WalkerFollow as PathFollow2D
@onready var balloon_follow := %BalloonFollow as PathFollow2D
@onready var walker_follow_2 := %WalkerFollow2 as PathFollow2D
@onready var spaceship_follow := %SpaceshipFollow as PathFollow2D


@onready var hot_air_balloon := %HotAirBalloon as HotAirBalloon
@onready var spaceship := %Spaceship as Spaceship
@onready var moon := $Moon as Moon

var game_state: GameState

enum State { SUBMARINE, DIVER, WALKER, BALLOON }
var previous_beat := 0
var current_beat := 0
var playing = false

func init(state: GameState) -> void:
	game_state = state
	camera_controller.init(state)
	moon.init(state)

func start() -> void:
	playing = true
	current_beat = BeatManager.get_start_beat()
	game_state.player.start()
	await submarine_async()
	await dive_async()
	await walk_async()
	await balloon_async()
	await walk_2_async()
	await spaceship_async()

func submarine_async() -> void:
	if current_beat >= SUBMARINE_BEAT: return
	if not playing: return
	
	previous_beat = 0
	# Reparent the player to the submarine and start camera tracking
	game_state.player.reparent(submarine_follow)
	game_state.player.position = Vector2.ZERO
	camera_controller.follow()
	
	# Lerp the submarine path
	await lerp_path(submarine_follow, 0, SUBMARINE_BEAT)

func dive_async() -> void:
	if current_beat >= DIVER_BEAT: return
	if not playing: return
	previous_beat = SUBMARINE_BEAT
	# Reparent the player to the dive, but lerp camera to balloon
	game_state.player.reparent(diver_follow)
	game_state.player.position = Vector2.ZERO
	game_state.player.fade_in()
	game_state.player.dive_anim()
	
	camera_controller.lerp_to(submarine.global_position)
	# Lerp the diver path
	await lerp_path(diver_follow, SUBMARINE_BEAT, DIVER_BEAT)

func walk_async() -> void:
	if current_beat >= WALKER_BEAT: return
	if not playing: return
	
	previous_beat = DIVER_BEAT
	# Reparent the player to the dive, and keep camera tracking
	print("Start Walking")
	game_state.player.reparent(walker_follow)
	game_state.player.position = Vector2.ZERO
	game_state.player.walk_anim()
	
	camera_controller.lerp_to(balloon.global_position)
	
	# Lerp the diver path
	await lerp_path(walker_follow, DIVER_BEAT, WALKER_BEAT)

func balloon_async() -> void:
	if current_beat >= BALLOON_BEAT: return
	if not playing: return
	previous_beat = WALKER_BEAT
	# Reparent the player to the dive, and keep camera tracking
	
	game_state.player.fade_out()
	hot_air_balloon.activate()
	game_state.player.reparent(balloon_follow)
	game_state.player.position = Vector2.ZERO
	camera_controller.follow()
	camera_controller.zoom_to(2.0);
	
	# Lerp the diver path
	await lerp_path(balloon_follow, WALKER_BEAT, BALLOON_BEAT)

func walk_2_async() -> void:
	if current_beat >= WALKER_2_BEAT: return
	if not playing: return

	previous_beat = BALLOON_BEAT
	hot_air_balloon.deactivate()
	game_state.player.fade_in()
	game_state.player.reparent(walker_follow_2)
	game_state.player.position = Vector2.ZERO
	game_state.player.walk_anim()
	camera_controller.lerp_to(spaceship_marker.global_position)
	
	await lerp_path(walker_follow_2, BALLOON_BEAT, WALKER_2_BEAT)

func spaceship_async() -> void:
	if current_beat >= SPACESHIP_BEAT: return
	if not playing: return

	previous_beat = WALKER_2_BEAT
	moon.scale_aync(1.1, 10.0)
	spaceship.activate()
	game_state.player.fade_out()
	game_state.player.reparent(spaceship_follow)
	game_state.player.position = Vector2.ZERO
	camera_controller.follow()
	camera_controller.zoom_to(1.0)
	
	await lerp_path(spaceship_follow, WALKER_2_BEAT, SPACESHIP_BEAT)

func lerp_path(path_follow: PathFollow2D, start_beat: int, end_beat: int) -> void:
	var start := float(current_beat - start_beat) / (end_beat - previous_beat)
	var total_time := BeatManager.beats_to_seconds(end_beat - start_beat)
	var timer := start * total_time
	while timer < total_time and playing:
		var t := timer / total_time
		path_follow.progress_ratio = t
		timer += get_process_delta_time()
		await Global.frame()
	previous_beat = start_beat
	current_beat = end_beat

func restart() -> void:
	playing = false
	moon.restart()
	await game_state.player.fade_out()
	submarine_follow.progress_ratio = 0
	diver_follow.progress_ratio = 0
	await camera_controller.lerp_to(camera_controller.original_pos)

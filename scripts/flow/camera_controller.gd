class_name CameraController
extends Camera2D

enum State { IDLE, FOLLOW, LERP, STOP }
var game_state: GameState
var camera_state := State.IDLE
var original_pos: Vector2
var original_zoom: Vector2

func _ready() -> void:
	original_pos = position
	original_zoom = zoom
	Global.zoom = zoom.x

func init(state: GameState) -> void:
	game_state = state
	follow()

func reset_zoom() -> void:
	zoom = original_zoom
	Global.zoom = zoom.x

func _process(_delta: float) -> void:
	if camera_state == State.IDLE: return
	
	match(camera_state):
		State.FOLLOW:
			var player_pos := game_state.player.global_position
			# if the player is still above, then follow
			if player_pos.y < global_position.y:
				global_position.y = player_pos.y

func lerp_to(target: Vector2, lerp_time: float = 1.0) -> void:
	camera_state = State.LERP
	var start := global_position
	var timer := 0.0
	
	while timer < lerp_time:
		var time := timer / lerp_time
		global_position = start.lerp(target, Global.ease_out_quart(time))
		var delta := get_process_delta_time()
		timer += delta
		await Global.frame()
	camera_state = State.STOP

func zoom_to(target: float, lerp_time: float = 1.0) -> void:
	var timer := 0.0
	var original_zoom := zoom
	while timer < lerp_time:
		var t := timer / lerp_time
		var x = lerp(original_zoom.x, target, Global.ease_out_sin(t))
		zoom = Vector2(x, x)
		Global.zoom = x
		timer += get_process_delta_time()
		await Global.frame()
	zoom = Vector2(target, target)
	Global.zoom = target

func follow() -> void:
	camera_state = State.FOLLOW

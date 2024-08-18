class_name CameraController
extends Camera2D

enum State { IDLE, FOLLOW, LERP, STOP }
var game_state: GameState
var camera_state := State.IDLE


func init(state: GameState) -> void:
	game_state = state
	follow()

func _process(delta: float) -> void:
	if camera_state == State.IDLE: return
	
	match(camera_state):
		State.FOLLOW:
			global_position = game_state.player.global_position

func lerp_to(target: Vector2, lerp_time: float = 1.0) -> void:
	camera_state = State.LERP
	var start := global_position
	var direction := (target - start).normalized()
	var timer := 0.0
	
	while timer < lerp_time:
		var time := timer / lerp_time
		global_position = start.lerp(target, Global.ease_out_quart(time))
		var delta := get_process_delta_time()
		timer += delta
		await Global.frame()
	camera_state = State.STOP

func follow() -> void:
	camera_state = State.FOLLOW

class_name CameraController
extends Camera2D

enum State { IDLE, FOLLOW, STOP }
var game_state: GameState
var camera_state := State.IDLE

var timeline = {
	0: State.FOLLOW,
	10: State.STOP,
	15: State.FOLLOW
}

func init(state: GameState) -> void:
	game_state = state
	camera_state = State.FOLLOW
	BeatManager.on_beat.connect(_on_beat)
	
func _process(delta: float) -> void:
	if camera_state == State.IDLE: return
	
	match(camera_state):
		State.FOLLOW:
			global_position = game_state.player.global_position

func _on_beat(beat: int) -> void:
	if timeline.has(beat):
		camera_state = timeline[beat]

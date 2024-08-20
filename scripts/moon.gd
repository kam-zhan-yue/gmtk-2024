class_name Moon
extends Sprite2D

var game_state: GameState
const OFFSET_Y = 25.0

enum State { IDLE, FOLLOW }
var state := State.IDLE
var original_pos := Vector2.ZERO
var original_scale := Vector2.ZERO
var playing := false

func _ready() -> void:
	original_pos = global_position
	original_scale = scale

func init(game: GameState) -> void:
	global_position = original_pos
	scale = original_scale
	game_state = game
	state = State.FOLLOW

func _process(_delta: float) -> void:
	if state == State.IDLE: return
	
	match(state):
		State.FOLLOW:
			var player_y := game_state.player.global_position.y
			# if the player is still above, then follow
			if player_y - OFFSET_Y < global_position.y:
				global_position.y = player_y - OFFSET_Y

func scale_aync(target: float, lerp_time := 1.0) -> void:
	var start := scale.x
	var timer := 0.0
	while timer < lerp_time:
		var t := Global.ease_out_sin(timer / lerp_time)
		var new_scale := start + (target - start) * t
		scale = Vector2(new_scale, new_scale)
		timer += get_process_delta_time()
		await Global.frame()
	scale = Vector2(target, target)
	
func restart() -> void:
	playing = false

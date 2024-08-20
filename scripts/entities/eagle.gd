class_name Eagle
extends Enemy

@export var orbit_radius := 150.0
@export var speed := 50.0
@export var charge_speed := 225.0
@export var wait_time := 2.0

enum State { MOVING, TRANSITION, WAITING, CHARGING }
var state := State.MOVING
var angle := 0.0
var timer := 0.0
var charge_direction := Vector2.ZERO

func _process(delta: float) -> void:
	if not game_state:
		return
	if state == State.MOVING:
		move()
	elif state == State.WAITING:
		wait(delta)
	elif state == State.CHARGING:
		charge(delta)

func move() -> void:
	state = State.TRANSITION
	var start_pos := global_position
	var player_pos := game_state.player.global_position
	var difference := player_pos - start_pos
	var direction := difference.normalized()
	var target_pos := player_pos - direction * orbit_radius
	var time_to_target := (target_pos - start_pos).length() / speed
	var timer := 0.0
	while not completed and timer < time_to_target:
		var t := timer / time_to_target
		global_position = start_pos.lerp(target_pos, Global.ease_out_quart(t))
		timer += get_process_delta_time()
		await Global.frame()
	start_waiting()

func start_waiting() -> void:
	state = State.WAITING
	timer = 0.0
	
func wait(delta: float) -> void:
	timer += delta
	if timer >= wait_time:
		state = State.CHARGING
		var player_pos := game_state.player.global_position
		var difference := player_pos - global_position
		charge_direction = difference.normalized()

func charge(delta: float) -> void:
	global_position += charge_direction * charge_speed * delta

class_name Eagle
extends Enemy

@export var orbit_radius := 150.0
@export var speed := 200.0
@export var charge_speed := 300.0
@export var wait_time := 2.0

enum State { MOVING, WAITING, CHARGING }
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
	var start_pos := global_position
	var player_pos := game_state.player.global_position
	var difference := player_pos - start_pos
	var direction := difference.normalized()
	if difference.length() <= orbit_radius:
		start_waiting()
		return
	global_position += direction * speed * get_process_delta_time()

func start_waiting() -> void:
	state = State.WAITING
	var player_pos := game_state.player.global_position
	var difference := global_position - player_pos
	angle = atan2(difference.y, difference.x)
	timer = 0.0
	
func wait(delta: float) -> void:
	var player_pos := game_state.player.global_position
	var x := player_pos.x + cos(angle) * orbit_radius
	var y := player_pos.y + sin(angle) * orbit_radius
	global_position = Vector2(x, y)
	timer += delta
	if timer >= wait_time:
		state = State.CHARGING
		var difference := player_pos - global_position
		charge_direction = difference.normalized()

func charge(delta: float) -> void:
	global_position += charge_direction * charge_speed * delta

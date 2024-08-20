class_name Eagle
extends Enemy

@export var orbit_radius := 150.0
@export var speed := 50.0
@export var charge_speed := 225.0
@export var wait_time := 2.0
@onready var anim: AnimatedSprite2D = %AnimatedSprite2D

enum State { MOVING, TRANSITION, WAITING, CHARGING }
var state := State.MOVING
var angle := 0.0
var timer := 0.0
var charge_direction := Vector2.ZERO
var previous_pos := Vector2.ZERO

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
		update_rotation()
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
		release_async()

func charge(delta: float) -> void:
	global_position += charge_direction * charge_speed * delta
	update_rotation()

func update_rotation() -> void:
	anim.flip_h = global_position.x <= previous_pos.x
	previous_pos = global_position
	
func release_async() -> void:
	await Global.seconds(5.0)
	queue_free()

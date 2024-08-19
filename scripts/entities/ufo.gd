class_name UFO
extends Enemy

@export var orbit_radius := 500.0
@export var speed := 300.0
@export var time_between_rockets := 2.0
@export var rocket_speed := 10.0
@export var rocket_data: EnemyData
const ROCKET = preload("res://scenes/projectiles/rocket.tscn")

enum State { MOVING, ORBITING }
var state := State.MOVING
var angle := 0.0

func _process(delta: float) -> void:
	if not game_state:
		return
	if state == State.MOVING:
		move()
	elif state == State.ORBITING:
		orbit()

func move() -> void:
	var start_pos := global_position
	var player_pos := game_state.player.global_position
	var difference := player_pos - start_pos
	var direction := difference.normalized()
	if difference.length() <= orbit_radius:
		start_orbit()
		return
	global_position += direction * speed * get_process_delta_time()
	pass

func start_orbit() -> void:
	state = State.ORBITING
	shoot_async()
	var player_pos := game_state.player.global_position
	var difference := global_position - player_pos
	angle = atan2(difference.y, difference.x)
	orbit()
	
func orbit() -> void:
	var player_pos := game_state.player.global_position
	var x := player_pos.x + cos(angle) * orbit_radius
	var y := player_pos.y + sin(angle) * orbit_radius
	global_position = Vector2(x, y)
	pass

func shoot_async() -> void:
	while(true):
		await Global.seconds(time_between_rockets)
		spawn_rocket()

func spawn_rocket() -> void:
	var rocket := ROCKET.instantiate() as Rocket
	rocket.global_position = global_position
	EntityManager.add_node(rocket)
	rocket.data = rocket_data
	rocket.init(game_state)

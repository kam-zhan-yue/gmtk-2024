class_name Satellite
extends Enemy

@export var orbit_radius := 100.0
@export var orbit_period := 10.0
@export var speed := 200.0
@export var laser_damage := 5.0

const LASER = preload("res://scenes/projectiles/laser.tscn")
enum State { MOVING, ORBITING }
var state := State.MOVING
var angle := 0.0

func _process(delta: float) -> void:
	if not game_state:
		return
	if state == State.MOVING:
		move()
	elif state == State.ORBITING:
		orbit(delta)

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
	print('angle is: ', rad_to_deg(angle))
	
func orbit(delta: float) -> void:
	var player_pos := game_state.player.global_position
	angle += 2 * PI / orbit_period * delta
	var x := player_pos.x + cos(angle) * orbit_radius
	var y := player_pos.y + sin(angle) * orbit_radius
	global_position = Vector2(x, y)
	pass

func shoot_async() -> void:
	while(true):
		await Global.seconds(1.0)
		var laser := LASER.instantiate() as Laser
		add_child(laser)
		laser.activate(self, game_state.player, 0.2)
		game_state.player.damage(laser_damage)

class_name UFO
extends Enemy

@export var orbit_radius := 500.0
@export var speed := 300.0
@export var time_between_rockets := 2.0
@export var rocket_speed := 10.0
@export var rocket_data: EnemyData
const ROCKET = preload("res://scenes/projectiles/rocket.tscn")

func _ready() -> void:
	on_init.connect(_on_init)
	
func _on_init() -> void:
	await lerp_async()
	shoot_async()

func lerp_async() -> void:
	var start_pos := global_position
	var player_pos := game_state.player.global_position
	var direction := (player_pos - start_pos).normalized()
	var target_pos := player_pos - direction * orbit_radius
	var time_to_target := (start_pos - target_pos).length() / speed
	var timer := 0.0
	
	while timer < time_to_target:
		var time := timer / time_to_target
		global_position = start_pos.lerp(target_pos, Global.ease_out_quart(time))
		timer += get_process_delta_time()
		await Global.frame()
	
	global_position = target_pos


func shoot_async() -> void:
	while(true):
		await Global.seconds(time_between_rockets)
		spawn_rocket()

func spawn_rocket() -> void:
	var rocket = ROCKET.instantiate() as Rocket
	EntityManager.add_node(rocket)
	rocket.data = rocket_data
	rocket.init(game_state)

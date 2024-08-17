class_name UFO 
extends Enemy

const ROCKET = preload("res://scenes/rocket.tscn")

func _ready() -> void:
	shoot_async()

func shoot_async() -> void:
	while(true):
		await Global.seconds(1.0)
		spawn_rocket()

func spawn_rocket() -> void:
	var rocket = ROCKET.instantiate() as Rocket
	add_child(rocket)
	rocket.init(game_state, "Rocket")

class_name Shark
extends Enemy

@export var bite_range := 50.0
@export var speed := 75.0
@export var bite_time := 2.0
@export var bite_damage := 10.0
@onready var audio := $AudioStreamPlayer2D as AudioStreamPlayer2D

enum State {SWIMMING, BITING, RETREATING}
var state := State.SWIMMING

func _process(delta: float) -> void:
	if completed:
		return
	if not game_state:
		return
	if state == State.SWIMMING:
		swim()
	elif state == State.BITING:
		bite()
	elif state == State.RETREATING:
		retreat()

func swim() -> void:
	var start_pos := global_position
	var player_pos := game_state.player.global_position
	var difference := player_pos - start_pos
	if difference.length() <= bite_range:
		bite_async()
		return
	move_to_player()

func move_to_player() -> void:
	var start_pos := global_position
	var player_pos := game_state.player.global_position
	var difference := player_pos - start_pos
	var direction := difference.normalized()
	if difference.length() <= bite_range:
		return
	global_position += direction * speed * get_process_delta_time()
	var angle := atan2(direction.y, direction.x)
	rotation = angle
	sprite.flip_v = Global.flip_v(angle)

func bite_async() -> void:
	state = State.BITING
	await Global.seconds(bite_time)
	if completed:
		return
	print("Bite Player!")
	game_state.player.damage(bite_damage)
	audio.play()
	state = State.RETREATING

func bite() -> void:
	move_to_player()

func retreat() -> void:
	var start_pos := global_position
	var player_pos := game_state.player.global_position
	var difference := start_pos - player_pos
	var direction := difference.normalized()
	global_position += direction * speed * get_process_delta_time()
	var angle := atan2(direction.y, direction.x)
	rotation = angle
	sprite.flip_v = Global.flip_v(angle)

class_name Shark
extends Enemy

@export var attack_range := 100.0
@export var speed := 100.0
@export var time_between_bites := 2.0
@export var bite_damage := 10.0
@onready var audio := $AudioStreamPlayer2D as AudioStreamPlayer2D

func _ready() -> void:
	on_init.connect(_on_init)
	
func _on_init() -> void:
	await lerp_async()
	bite_async()

func lerp_async() -> void:
	var start_pos := global_position
	var player_pos := game_state.player.global_position
	var direction := (player_pos - start_pos).normalized()
	var target_pos := player_pos - direction * attack_range
	var time_to_target := (start_pos - target_pos).length() / speed
	var timer := 0.0
	
	while timer < time_to_target:
		var time := timer / time_to_target
		global_position = start_pos.lerp(target_pos, Global.ease_out_sin(time))
		timer += get_process_delta_time()
		await Global.frame()
	
	global_position = target_pos


func bite_async() -> void:
	while(true):
		await Global.seconds(time_between_bites)
		bite()

func bite() -> void:
	print("Bite Player!")
	game_state.player.damage(bite_damage)
	audio.play()

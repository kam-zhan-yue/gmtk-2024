class_name Enemy
extends Node2D

@export var using_anim := false
@onready var type_entity := $TypeEntity as TypeEntity

const FADE_OUT = 1.0
var game_state: GameState
var data: EnemyData
var completed := false
signal on_init


func init(state: GameState, enemy_data: EnemyData) -> void:
	game_state = state
	data = enemy_data
	type_entity.init(data.name)
	type_entity.on_complete.connect(_on_complete)
	
	game_state.init_type_entity(type_entity)
	on_init.emit()
	
func _on_complete() -> void:
	completed = true
	game_state.enemy_dead(data)
	release()

func release() -> void:
	var timer := 0.0
	while timer < FADE_OUT:
		var t := timer / FADE_OUT
		if not using_anim:
			$Sprite2D.modulate.a = 1-t
		else:
			%AnimatedSprite2D.modulate.a = 1-t
		timer += get_process_delta_time()
		await Global.frame()
	await Global.seconds(1.0)
	queue_free()

func activate_type() -> void:
	type_entity.activate()

func deactivate_type() -> void:
	type_entity.deactivate()

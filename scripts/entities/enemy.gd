class_name Enemy
extends Node2D

@export var data: EnemyData
@onready var type_entity := $TypeEntity as TypeEntity
@onready var sprite := $Sprite2D as Sprite2D

const FADE_OUT = 1.0
var game_state: GameState
var completed := false
signal on_init

func init(state: GameState) -> void:
	self.game_state = state
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
		sprite.modulate.a = 1-t
		timer += get_process_delta_time()
		await Global.frame()
	await Global.seconds(1.0)
	queue_free()

func activate_type() -> void:
	type_entity.activate()

func deactivate_type() -> void:
	type_entity.deactivate()

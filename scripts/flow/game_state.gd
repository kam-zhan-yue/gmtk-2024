class_name GameState
extends Node

var player: Player

signal init_entity(entity: TypeEntity)
signal on_enemy_dead(data: EnemyData)
var combo := 1
var score := 0.0
signal on_combo(value: int)
signal on_score(value: float)
signal on_damage(value: float)
signal on_start

func _init(p: Player = null) -> void:
	player = p
	player.on_damage.connect(_on_damage)

func start() -> void:
	player.start()
	on_start.emit()

func init_type_entity(entity: TypeEntity) -> void:
	init_entity.emit(entity)

func enemy_dead(data: EnemyData) -> void:
	on_enemy_dead.emit(data)
	score += data.score
	combo += 1
	on_combo.emit(combo)
	on_score.emit(score)

func _on_damage(value: float) -> void:
	combo = 0
	on_combo.emit(combo)
	on_damage.emit(value)	

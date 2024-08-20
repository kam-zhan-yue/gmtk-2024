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
signal on_pause(value: bool)
signal on_start
signal on_restart
signal on_end_game
var started := false

func _init(p: Player = null) -> void:
	player = p
	player.on_damage.connect(_on_damage)
	started = false

func start() -> void:
	started = true
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

func pause(value: bool) -> void:
	on_pause.emit(value)

func restart() -> void:
	on_restart.emit()

func end_game() -> void:
	on_end_game.emit()

func clear() -> void:
	player.clear()

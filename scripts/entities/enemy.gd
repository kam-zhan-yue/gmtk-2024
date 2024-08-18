class_name Enemy
extends Node2D

@export var data: EnemyData
@onready var type_entity := $TypeEntity as TypeEntity

var game_state: GameState
signal on_init

func init(state: GameState) -> void:
	self.game_state = state
	type_entity.init(data.name)
	type_entity.on_complete.connect(_on_complete)
	on_init.emit()
	
func _on_complete() -> void:
	queue_free()

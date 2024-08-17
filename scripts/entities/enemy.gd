class_name Enemy
extends Node

@onready var type_entity := %TypeEntity as TypeEntity

var game_state: GameState

func init(game_state: GameState, data: String) -> void:
	self.game_state = game_state
	type_entity.init(data)
	type_entity.on_complete.connect(_on_complete)
	
func _on_complete() -> void:
	queue_free()

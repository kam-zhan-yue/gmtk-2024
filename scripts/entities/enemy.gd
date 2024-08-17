class_name Enemy
extends Node2D

@export var speed := 0.1
@onready var type_entity := %TypeEntity as TypeEntity
@onready var path_follow := $"." as PathFollow2D

var game_state: GameState

func init(game_state: GameState, data: String) -> void:
	self.game_state = game_state
	type_entity.init(data)
	type_entity.on_complete.connect(_on_complete)
	
func _on_complete() -> void:
	queue_free()

class_name Rocket
extends Node2D

@export var speed := 0.5
@onready var type_entity := %TypeEntity as TypeEntity

var game_state: GameState

func init(game_state: GameState, word: String) -> void:
	self.game_state = game_state
	type_entity.init(word)
	type_entity.on_complete.connect(_on_complete)

func _process(delta: float) -> void:
	if not game_state:
		return
	var player := game_state.player
	var direction := player.global_position - global_position
	global_position += direction * speed * delta

func _on_complete() -> void:
	queue_free()

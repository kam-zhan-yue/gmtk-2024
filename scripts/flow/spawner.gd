class_name Spawner
extends Node2D

const CONFIG = preload("res://resources/spawn_settings.tres")

var game_state: GameState

func _ready() -> void:
	BeatManager.on_beat.connect(_on_beat)

func init(state: GameState) -> void:
	self.game_state = state

func _on_beat(beat: int) -> void:
	var spawn_group = CONFIG.spawn(beat)
	if spawn_group:
		if spawn_group.parent_to_player:
			game_state.player.add_node(spawn_group)
		else:
			EntityManager.add_node(spawn_group)
		spawn_group.init(game_state)
		spawn_group.position += game_state.player.position

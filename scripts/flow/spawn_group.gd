class_name SpawnGroup
extends Node2D

func init(game_state: GameState) -> void:
	for node in get_children():
		if node is Enemy:
			node.init(game_state, "test")

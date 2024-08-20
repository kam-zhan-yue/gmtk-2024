class_name SpawnGroup
extends Node2D

@export var parent_to_player := false

func init(game_state: GameState, enemy_data: EnemyData) -> void:
	init_recursive(self, game_state, enemy_data)

func init_recursive(node: Node, game_state: GameState, enemy_data: EnemyData) -> void:
	for n in node.get_children():
		if n is Enemy:
			(n as Enemy).init(game_state, enemy_data)
		else:
			init_recursive(n, game_state, enemy_data)

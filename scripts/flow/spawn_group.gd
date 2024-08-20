class_name SpawnGroup
extends Node2D

@export var parent_to_player := false

func init(game_state: GameState) -> void:
	init_recursive(self, game_state)

func init_recursive(node: Node, game_state: GameState) -> void:
	for n in node.get_children():
		print(n.name)
		if n is Enemy:
			(n as Enemy).init(game_state)
		else:
			init_recursive(n, game_state)

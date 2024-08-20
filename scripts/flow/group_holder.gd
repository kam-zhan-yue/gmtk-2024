class_name GroupHolder
extends Node2D

var game_state: GameState

func init(state: GameState) -> void:
	for group in get_children():
		if group is SpawnTrigger:
			(group as SpawnTrigger).init(game_state)

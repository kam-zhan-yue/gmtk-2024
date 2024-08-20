class_name SpawnTrigger
extends Node2D

@export var group: PackedScene
@export var data: EnemyData

var game_state: GameState
var spawned := false

func init(state: GameState):
	game_state = state

func _process(_delta: float) -> void:
	if not game_state: return
	if spawned: return
	var player_y := game_state.player.global_position.y
	if player_y <= global_position.y and player_y > global_position.y - 50.0:
		spawn()

func spawn() -> void:
	spawned = true
	var spawn_group := group.instantiate() as SpawnGroup
	# Need to add as child (for positioning,
	# then init to ensure recursive function
	# then reparent for precision
	add_child(spawn_group)
	spawn_group.init(game_state, data)

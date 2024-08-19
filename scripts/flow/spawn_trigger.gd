class_name SpawnTrigger
extends Node2D

@export var group: PackedScene

var game_state: GameState
var spawned := false

func init(state: GameState):
	game_state = state

func _process(delta: float) -> void:
	if not game_state: return
	if spawned: return
	if game_state.player.global_position.y <= global_position.y:
		spawn()

func spawn() -> void:
	spawned = true
	print(str("Spawning ", group.resource_name, "!"))
	var spawn := group.instantiate() as SpawnGroup
	# Need to add as child (for positioning,
	# then init to ensure recursive function
	# then reparent for precision
	add_child(spawn)
	spawn.init(game_state)
	#if spawn.parent_to_player:
		#spawn.reparent(game_state.player.spawns)
	#else:
		#spawn.reparent(EntityManager)

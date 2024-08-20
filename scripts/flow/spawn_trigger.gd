class_name SpawnTrigger
extends Node2D

@export var left_group: PackedScene
@export var right_group: PackedScene
@export var offset_y := -200.0
@export var data: EnemyData

var game_state: GameState
var spawned := false

func init(state: GameState):
	game_state = state
	spawned = false

func _process(_delta: float) -> void:
	if not game_state: return
	if spawned: return
	var player_y := game_state.player.global_position.y
	if player_y <= global_position.y and player_y > global_position.y - 50.0:
		spawn()

func spawn() -> void:
	spawned = true
	spawn_group(left_group)
	spawn_group(right_group)

func spawn_group(scene: PackedScene) -> void:
	if not scene:
		return
	
	var group := scene.instantiate() as SpawnGroup
	# Need to add as child (for positioning,
	# then init to ensure recursive function
	# then reparent for precision
	print(str("Spawning: ", name))
	add_child(group)
	group.position.y += offset_y
	group.init(game_state, data)

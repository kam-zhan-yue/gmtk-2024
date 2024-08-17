class_name Spawner
extends Node2D

const ENTITY = preload("res://scenes/ufo.tscn")
const random = ["Apple Pie", "Tuna", "Oreo", "Broccoli"]

var game_state: GameState

func init(game_state: GameState) -> void:
	self.game_state = game_state

func spawn_async() -> void:
	while(true):
		var time = randf_range(0.2, 1.0)
		await Global.seconds(time)
		spawn()


func spawn() -> void:
	var entity = ENTITY.instantiate() as Enemy
	
	var player := game_state.player
	
	if player:
		# Get the player's position
		var player_position = player.position
		
		# Generate a random distance and angle
		var distance = randf_range(300, 500)
		var angle = randf_range(0, 2 * PI)
		
		# Calculate the new position based on the random distance and angle
		var spawn_position = player_position + Vector2(
			cos(angle) * distance,
			sin(angle) * distance
		)
		
		# Set the entity's position to the new spawn position
		entity.position = spawn_position
	
	# Add the entity to the scene tree as a child of the current node
	add_child(entity)
	entity.init(game_state, random[randi_range(0, len(random)-1)])

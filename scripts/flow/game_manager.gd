class_name GameManager
extends Node

@onready var player := %Player as Player
@onready var spawner: Spawner = %Spawner

var game_state: GameState

func _ready() -> void:
	game_state = GameState.new(player)
	spawner.init(game_state)
	spawner.spawn_async()
	

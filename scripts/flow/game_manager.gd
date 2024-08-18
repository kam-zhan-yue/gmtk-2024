class_name GameManager
extends Node

@onready var player := %Player as Player
@onready var spawner := %Spawner as Spawner
@onready var entity_popup := %EntityPopup as EntityPopup
@onready var camera_controller := $"../CameraController" as CameraController

var game_state: GameState

func _ready() -> void:
	game_state = GameState.new(player)
	camera_controller.init(game_state)
	spawner.init(game_state)
	entity_popup.init(game_state)
	BeatManager.start()

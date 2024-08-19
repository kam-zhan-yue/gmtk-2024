class_name StartPopup
extends Control

var game_state: GameState
var started := false

func init(state: GameState):
	game_state = state

func _input(event: InputEvent):
	if started:
		return
	if event.is_action_pressed("ui_cancel"):
		return
	if event is InputEventMouseButton or event is InputEventKey:
		started = true
		game_state.start()
		Global.set_inactive(self)

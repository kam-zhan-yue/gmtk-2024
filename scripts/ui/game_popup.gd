class_name GamePopup
extends Control
@onready var pause_popup := %PausePopup as PausePopup

var game_state: GameState

func _ready() -> void:
	Global.set_inactive(pause_popup)
	pause_popup.on_restart_button_pressed.connect(_on_restart)

func init(state: GameState) -> void:
	game_state = state

func _input(event: InputEvent) -> void:
	if not game_state: 
		return
	if not game_state.started:
		return
	if event.is_action_pressed("ui_cancel"):
		toggle_pause()

func toggle_pause() -> void:
	Global.active(pause_popup, !pause_popup.visible)
	var paused = pause_popup.visible
	Engine.time_scale = 0.0 if paused else 1.0
	game_state.pause(paused)

func _on_restart() -> void:
	toggle_pause()
	game_state.restart()
	

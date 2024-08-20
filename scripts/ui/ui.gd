class_name UI
extends CanvasLayer

@onready var entity_popup := %EntityPopup as EntityPopup
@onready var score_popup := %ScorePopup as ScorePopup
@onready var pause_popup := %PausePopup as PausePopup
@onready var start_popup := %StartPopup as StartPopup
@onready var game_popup := $GamePopup as GamePopup
@onready var fade_popup := $FadePopup as FadePopup

func init(state: GameState) -> void:
	start_popup.init(state)
	entity_popup.init(state)
	score_popup.init(state)
	game_popup.init(state)

func fade_in() -> void:
	print('fade in!')
	await fade_popup.show_popup()

func fade_out() -> void:
	await fade_popup.hide_popup()
	start_popup.show_popup()

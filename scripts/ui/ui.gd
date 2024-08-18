class_name UI
extends CanvasLayer

@onready var entity_popup := %EntityPopup as EntityPopup
@onready var score_popup := %ScorePopup as ScorePopup
@onready var pause_popup := %PausePopup as PausePopup
@onready var start_popup := %StartPopup as StartPopup

func init(state: GameState) -> void:
	start_popup.init(state)
	entity_popup.init(state)
	score_popup.init(state)

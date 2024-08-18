class_name UI
extends CanvasLayer

@onready var entity_popup := %EntityPopup as EntityPopup
@onready var score_popup := %ScorePopup as ScorePopup
@onready var pause_popup := %PausePopup as PausePopup


func init(state: GameState) -> void:
	entity_popup.init(state)
	score_popup.init(state)

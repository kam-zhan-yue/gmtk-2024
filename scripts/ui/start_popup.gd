class_name StartPopup
extends Control

var game_state: GameState
var started := false

@onready var title_popup := $TitlePopup as TitlePopup
@onready var credits_popup := $CreditsPopup as CreditsPopup

func init(state: GameState):
	game_state = state
	title_popup.init()
	credits_popup.init()
	title_popup.on_play.connect(play_game)
	title_popup.on_credits.connect(show_credits)
	credits_popup.on_back.connect(show_title)
	show_title()

func show_popup() -> void:
	Global.set_active(self)
	show_title()

func play_game() -> void:
	started = true
	game_state.start()
	Global.set_inactive(self)

func show_credits() -> void:
	title_popup.hide_popup()
	credits_popup.show_popup()

func show_title() -> void:
	title_popup.show_popup()
	credits_popup.hide_popup()
	

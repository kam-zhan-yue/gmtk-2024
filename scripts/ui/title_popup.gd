class_name TitlePopup
extends MarginContainer

@onready var play_label := %PlayLabel as TypeLabel
@onready var play_entity := %PlayEntity as TypeEntity

@onready var credit_label := %CreditLabel as TypeLabel
@onready var credit_entity := %CreditEntity as TypeEntity

signal on_play
signal on_credits

func init():
	play_label.init(play_entity)
	credit_label.init(credit_entity)
	play_entity.on_complete.connect(play)
	credit_entity.on_complete.connect(credits)

func play() -> void:
	on_play.emit()

func credits() -> void:
	on_credits.emit()
	
func show_popup():
	Global.set_active(self)
	play_entity.init("play")
	credit_entity.init("credits")
	
	play_entity.activate()
	credit_entity.activate()

func hide_popup():
	Global.set_inactive(self)
	play_entity.deactivate()
	credit_entity.deactivate()

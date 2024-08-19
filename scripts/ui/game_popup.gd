extends Control
@onready var pause_popup := %PausePopup as PausePopup

func _ready() -> void:
	Global.set_inactive(pause_popup)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		get_tree().paused = !get_tree().paused
		Global.active(pause_popup, !pause_popup.visible)
		

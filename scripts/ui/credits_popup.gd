class_name CreditsPopup
extends MarginContainer

@onready var back_entity := %BackEntity as TypeEntity
@onready var back_label := $VBoxContainer/BackLabel as TypeLabel

signal on_back

func init() -> void:
	back_label.init(back_entity)
	back_entity.on_complete.connect(back)

func back() -> void:
	on_back.emit()

func show_popup() -> void:
	Global.set_active(self)
	back_entity.init("back")
	back_entity.activate()
	
func hide_popup() -> void:
	Global.set_inactive(self)
	back_entity.deactivate()

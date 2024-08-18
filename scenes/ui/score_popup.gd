class_name ScorePopup
extends Control
@onready var score_label := %ScoreLabel as RichTextLabel
@onready var combo_label := %ComboLabel as RichTextLabel

func init(state: GameState) -> void:
	_on_score(0.0)
	_on_combo(0)
	state.on_score.connect(_on_score)
	state.on_combo.connect(_on_combo)

func _on_score(value: float) -> void:
	score_label.text = str(value)
	pass

func _on_combo(value: int) -> void:
	if value == 0:
		Global.set_inactive(combo_label)
	else:
		Global.set_active(combo_label)
		var combo = str("Combo: ", value, "x")
		var shake = str("[shake rate=",value," level=10 connected=1]", combo, "[/shake]")
		combo_label.text = shake

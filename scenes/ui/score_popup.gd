class_name ScorePopup
extends Control
@onready var score_label := %ScoreLabel as RichTextLabel
@onready var combo_label := %ComboLabel as RichTextLabel

func init(state: GameState) -> void:
	state.on_score.connect(_on_score)
	state.on_combo.connect(_on_combo)

func _on_score(value: float) -> void:
	score_label.text = str(value)
	pass

func _on_combo(value: int) -> void:
	combo_label.text = str(value)
	pass

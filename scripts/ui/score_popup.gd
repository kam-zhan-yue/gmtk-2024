class_name ScorePopup
extends Control
@onready var score_label := %ScoreLabel as RichTextLabel
@onready var combo_label := %ComboLabel as RichTextLabel

var score_tween: Tween
var combo_tween: Tween

func init(state: GameState) -> void:
	_on_score(0.0)
	_on_combo(0)
	state.on_score.connect(_on_score)
	state.on_combo.connect(_on_combo)

func _on_score(value: float) -> void:
	if score_tween:
		score_tween.kill()
	var current_score := float(score_label.text)
	score_tween = get_tree().create_tween()
	score_tween.set_trans(Tween.TRANS_LINEAR)
	score_tween.tween_method(set_score_label, current_score, value, 1.0)

func set_score_label(value: float) -> void:
	score_label.text = str(int(value))

func _on_combo(value: int) -> void:
	if value == 0:
		Global.set_inactive(combo_label)
		return
	Global.set_active(combo_label)
	var combo := str("Combo: ", value, "x")
	var shake := str("[shake rate=",value," level=10 connected=1]", combo, "[/shake]")
	combo_label.text = shake
	if combo_tween:
		combo_tween.kill()
	combo_label.scale = Vector2.ONE
	combo_tween = get_tree().create_tween()
	combo_tween.tween_property(combo_label, "scale", Vector2(1.25, 1.25), 0.08).set_trans(Tween.TRANS_CUBIC)
	combo_tween.tween_property(combo_label, "scale", Vector2.ONE, 0.08).set_trans(Tween.TRANS_CUBIC)
	combo_tween.set_ease(Tween.EASE_OUT)

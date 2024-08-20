class_name FadePopup
extends Control

const FADE_TIME := 5.0
@onready var color_rect := $ColorRect as ColorRect

func _ready():
	Global.set_inactive(self)

func show_popup():
	Global.set_active(self)
	
	color_rect.modulate.a = 0.0
	var timer := 0.0
	while timer < FADE_TIME:
		timer += get_process_delta_time()
		var t := timer / FADE_TIME
		color_rect.modulate.a = t
		await Global.frame()

func hide_popup():
	color_rect.modulate.a = 1.0
	var timer := 0.0
	while timer < FADE_TIME:
		timer += get_process_delta_time()
		var t := timer / FADE_TIME
		color_rect.modulate.a = t
		await Global.frame()
	color_rect.modulate.a = 0.0
	Global.set_inactive(self)

class_name PausePopup
extends Control

@onready var music_bus = AudioServer.get_bus_index("Music")
@onready var effects_bus = AudioServer.get_bus_index("Effects")


func _on_music_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(music_bus, linear_to_db(value))
	AudioServer.set_bus_mute(music_bus, value < .05)


func _on_effects_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(effects_bus, linear_to_db(value))
	AudioServer.set_bus_mute(effects_bus, value < .05)

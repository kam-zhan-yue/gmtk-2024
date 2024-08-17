extends Node

signal on_key_pressed(key: String)
signal on_backspace

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventKey and event.is_pressed():
		var typed_event := event as InputEventKey
		if typed_event.keycode == KEY_BACKSPACE:
			on_backspace.emit()

	if event is InputEventKey and event.is_pressed() and not event.is_echo():
		var typed_event := event as InputEventKey
		var unicode := typed_event.unicode
		if unicode < 32 or unicode > 122:
			return
		var raw_input := PackedByteArray([typed_event.unicode]).get_string_from_utf8()
		on_key_pressed.emit(raw_input)

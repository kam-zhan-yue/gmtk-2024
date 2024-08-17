class_name InputDebugger
extends Control

@onready var display := $Display as RichTextLabel

var input: String

func _ready() -> void:
	InputManager.on_key_pressed.connect(_on_key_pressed)
	InputManager.on_backspace.connect(_on_backspace)
	
func _on_key_pressed(key: String) -> void:
	input += key
	display.text = input

func _on_backspace() -> void:
	input = input.left(input.length() - 1)
	display.text = input

class_name TypeEntity
extends Node2D

@onready var rich_text_label := $RichTextLabel as RichTextLabel

func _ready() -> void:
	InputManager.on_key_pressed.connect(_on_key_pressed)
	
func _on_key_pressed(key: String) -> void:
	rich_text_label.append_text(key)

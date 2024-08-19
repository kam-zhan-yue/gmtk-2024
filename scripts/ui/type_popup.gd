class_name TypePopup
extends Control

const OFFSET_Y = 30.0
var entity: TypeEntity
@onready var rich_text_label := $RichTextLabel as RichTextLabel
var completed := false

func _ready() -> void:
	Global.set_inactive(rich_text_label)

func init(type_entity: TypeEntity) -> void:
	position = Vector2(-100, -100)
	entity = type_entity
	rich_text_label.text = str('\n', entity.get_display_string())
	entity.on_update.connect(_on_update)
	entity.on_complete.connect(_on_complete)
	entity.on_active.connect(_on_active)

func _process(delta: float) -> void:
	if completed: return
	if not entity: return
	var global_position = entity.global_position
	var viewport_rect := get_viewport_rect()
	var camera := get_viewport().get_camera_2d()
	var screen_center := camera.get_screen_center_position()
	var difference := entity.global_position - screen_center
	var screen_position := get_screen_center() + difference * Global.SCALE
	var offset_position := Vector2(screen_position.x, screen_position.y + OFFSET_Y)
	position = offset_position

func get_screen_center() -> Vector2:
	var rect := get_viewport_rect().size * 0.5
	return Vector2(rect.x - size.x * 0.5, rect.y - size.y * 0.5)

func _on_active(active: bool) -> void:
	if active:
		Global.set_active(rich_text_label)
	else:
		Global.set_inactive(rich_text_label)

func _on_update(text: String) -> void:
	rich_text_label.text = str('\n', text)

func _on_complete() -> void:
	completed = true
	var text := rich_text_label.text
	var wave := str("[wave amp=50.0 freq=5.0 connected=1]", text, "[/wave]")
	var pulse := str("[pulse freq=1 color=#ffffff00 ease=-2.0]", wave, "[/pulse]")
	rich_text_label.text = pulse
	await Global.seconds(1)
	queue_free()

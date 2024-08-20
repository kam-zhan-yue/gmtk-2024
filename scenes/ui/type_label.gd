class_name TypeLabel
extends RichTextLabel

var entity: TypeEntity

func init(type_entity: TypeEntity) -> void:
	entity = type_entity
	entity.on_update.connect(_on_update)
	#entity.on_activate.connect(_on_activate)
	
func _on_activate(value: bool) -> void:
	_on_update(entity.get_display_string())

func _on_update(value: String) -> void:
	text = value
	pass

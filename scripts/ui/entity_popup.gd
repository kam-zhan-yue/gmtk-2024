class_name EntityPopup
extends Control

const TYPE_POPUP = preload("res://scenes/ui/type_popup.tscn")

func init(game_state: GameState) -> void:
	game_state.init_entity.connect(_on_init_entity)
	
func _on_init_entity(entity: TypeEntity) -> void:
	var type_popup = TYPE_POPUP.instantiate() as TypePopup
	add_child(type_popup)
	type_popup.init(entity)

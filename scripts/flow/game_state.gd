class_name GameState
extends Node

var player: Player

signal init_entity(entity: TypeEntity)

func _init(p: Player = null) -> void:
	self.player = p


func init_type_entity(entity: TypeEntity) -> void:
	init_entity.emit(entity)

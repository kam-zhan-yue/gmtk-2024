class_name Rocket
extends Node2D

@export var speed := 100.0
@onready var type_entity := %TypeEntity as TypeEntity

var game_state: GameState
var damage := 1.0

func init(game_state: GameState, word: String, damage: float) -> void:
	self.game_state = game_state
	self.damage = damage
	type_entity.init(word)
	type_entity.on_complete.connect(_on_complete)

func _process(delta: float) -> void:
	if not game_state:
		return
	var player := game_state.player
	var direction := (player.global_position - global_position).normalized()
	global_position += direction * speed * delta

func _on_complete() -> void:
	queue_free()

func _on_area_2d_area_entered(area: Area2D) -> void:
	if area is not Health:
		return
	var health = area as Health
	type_entity.on_complete.disconnect(_on_complete)
	health.damage(damage)
	queue_free()
	

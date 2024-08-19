class_name Player
extends Node2D

@export var speed := 30.0
@onready var health := %Health as Health
@onready var anim := $AnimatedSprite2D as AnimatedSprite2D
@onready var point_light_2d := $PointLight2D as PointLight2D
@onready var spawns: Node2D = %Spawns

const FADE_OUT = 1.0
var started := false
signal on_damage(value: float)

enum State { SUBMARINE, DIVER, WALKER, BALLOON }
var state := State.SUBMARINE

func _ready() -> void:
	Global.set_inactive(anim)
	health.init()
	health.on_damage.connect(_on_damage)
	health.on_dead.connect(_on_dead)
	point_light_2d.enabled = false

func start() -> void:
	started = true
	point_light_2d.enabled = true
	anim.modulate.a = 1
	point_light_2d.energy = 1.0

func _on_dead() -> void:
	print("Player is dead")

func dive_anim() -> void:
	Global.set_active(anim)
	anim.play("diver")

func walk_anim() -> void:
	Global.set_active(anim)
	anim.play("walker")

func damage(amount: float) -> void:
	health.damage(amount)

func _on_damage(value: float) -> void:
	on_damage.emit(value)

func add_node(node: Node2D) -> void:
	spawns.add_child(node)

func restart() -> void:
	started = false
	for node in spawns.get_children():
		node.queue_free()
	await release()

func release() -> void:
	var timer := 0.0
	while timer < FADE_OUT:
		var t := timer / FADE_OUT
		anim.modulate.a = 1-t
		point_light_2d.energy = 1-t
		timer += get_process_delta_time()
		await Global.frame()
	point_light_2d.enabled = false
	point_light_2d.energy = 0.0

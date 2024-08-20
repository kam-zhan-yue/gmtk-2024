class_name Player
extends Node2D

@export var speed := 30.0
@onready var health := %Health as Health
@onready var anim := $AnimatedSprite2D as AnimatedSprite2D
@onready var spawns: Node2D = %Spawns

const FADE_OUT = 1.0
var started := false
signal on_damage(value: float)

enum State { SUBMARINE, DIVER, WALKER, BALLOON }
var state := State.SUBMARINE

func _ready() -> void:
	health.init()
	health.on_damage.connect(_on_damage)
	health.on_dead.connect(_on_dead)

func start() -> void:
	started = true
	anim.modulate.a = 0.0

func _on_dead() -> void:
	print("Player is dead")

func dive_anim() -> void:
	anim.play("diver")

func walk_anim() -> void:
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

func fade_out(fade_time := 0.2) -> void:
	print("Fade out player")
	anim.modulate.a = 1.0
	var timer := 0.0
	while timer < fade_time:
		var t := timer / fade_time
		anim.modulate.a = 1-t
		timer += get_process_delta_time()
		await Global.frame()
	anim.modulate.a = 0.0

func fade_in(fade_time := 0.2) -> void:
	print("Fade in player")
	anim.modulate.a = 0.0
	var timer := 0.0
	while timer < fade_time:
		var t := timer / fade_time
		anim.modulate.a = t
		timer += get_process_delta_time()
		await Global.frame()
	anim.modulate.a = 1.0

func release() -> void:
	var timer := 0.0
	while timer < FADE_OUT:
		var t := timer / FADE_OUT
		anim.modulate.a = 1-t
		timer += get_process_delta_time()
		await Global.frame()

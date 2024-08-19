class_name Player
extends Node2D

@export var speed := 30.0
@onready var health := %Health as Health
@onready var anim := $AnimatedSprite2D as AnimatedSprite2D
@onready var point_light_2d := $PointLight2D as PointLight2D
@onready var spawns: Node2D = %Spawns

var started := false
signal on_damage(value: float)

func _ready() -> void:
	anim.play("diver_swim")
	health.init()
	health.on_damage.connect(_on_damage)
	health.on_dead.connect(_on_dead)
	point_light_2d.enabled = false

func start() -> void:
	started = true
	point_light_2d.enabled = true

func _process(delta: float) -> void:
	if not started: return
	global_position.y -= speed * delta

func _on_dead() -> void:
	print("Player is dead")

func damage(amount: float) -> void:
	health.damage(amount)

func _on_damage(value: float) -> void:
	on_damage.emit(value)
	

func add_node(node: Node2D) -> void:
	spawns.add_child(node)

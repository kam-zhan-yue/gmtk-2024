extends Node2D

@onready var parent := $".." as Boid
@onready var sprite := %Sprite2D as Sprite2D
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

const FADE_OUT = 1.0
var timer := 0.0

func _ready() -> void:
	parent.on_uninit.connect(release)
	if animated_sprite_2d:
		animated_sprite_2d.play("default")

func release() -> void:
	var timer := 0.0
	while timer < FADE_OUT:
		var t := timer / FADE_OUT
		if sprite:
			sprite.modulate.a = 1-t
		elif animated_sprite_2d:
			animated_sprite_2d.modulate.a = 1-t
		timer += get_process_delta_time()
		await Global.frame()
	await Global.seconds(1.0)
	queue_free()

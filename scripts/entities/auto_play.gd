extends AnimatedSprite2D

@export var anim_name := "default"
@export var randomise := false

func _ready() -> void:
	var frames := sprite_frames.get_frame_count(anim_name)
	var random_frame := randi() % frames
	frame = random_frame
	play(anim_name)

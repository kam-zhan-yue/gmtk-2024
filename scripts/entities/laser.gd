class_name Laser
extends RayCast2D
@onready var line := $Line2D as Line2D
@onready var casting_particles := $CastingParticles as GPUParticles2D
@onready var collision_particles := $CollisionParticles as GPUParticles2D
@onready var beam_particles := $BeamParticles as GPUParticles2D

var mouse_position := Vector2.ZERO

var is_casting: bool = false :
	set(value): 
		is_casting = value
		
		beam_particles.emitting = is_casting
		casting_particles.emitting = is_casting
		
		if is_casting:
			appear()
		else:
			collision_particles.emitting = false
			disapear()
		set_physics_process(is_casting)

func _ready():
	is_casting = false


func activate(start: Node2D, end: Node2D, time: float) -> void:
	is_casting = true
	var timer := 0.0
	var trigger_off := false
	while timer < time:
		timer += get_process_delta_time()
		update_laser(start.global_position, end.global_position)
		if not trigger_off and timer > time - 0.1:
			is_casting = false
		await Global.frame()
	update_laser(start.global_position, end.global_position)

func update_laser(start: Vector2, end: Vector2) -> void:
	var cast_point := to_local(end)
	collision_particles.position = cast_point
	line.points[0] = Vector2.ZERO
	line.points[1] = cast_point
	beam_particles.position = cast_point * 0.5
	beam_particles.process_material.emission_box_extents.x = cast_point.length() * 0.5


func appear() -> void:
	var tween = create_tween()
	tween.tween_property(line, "width", 5.0, 0.2)


func disapear() -> void:
	var tween = create_tween()
	tween.tween_property(line, "width", 0, 0.1)

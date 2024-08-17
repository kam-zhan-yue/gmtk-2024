extends RayCast2D

@onready var casting_particles := $CastingParticles as GPUParticles2D
@onready var collision_particles := $CollisionParticles as GPUParticles2D
@onready var beam_particles := $BeamParticles as GPUParticles2D

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
	is_casting = true

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		print("Laser")
		self.is_casting = event.pressed

func _physics_process(delta: float) -> void:
	var cast_point := target_position
	force_raycast_update()
	
	collision_particles.emitting = is_colliding()
	
	if is_colliding():
		cast_point = to_local(get_collision_point())
		collision_particles.global_rotation = get_collision_normal().angle()
		collision_particles.position = cast_point
	
	$Line2D.points[1] = cast_point
	beam_particles.position = cast_point * 0.5
	beam_particles.process_material.emission_box_extents.x = cast_point.length() * 0.5
	

		
func appear() -> void:
	var tween = create_tween()
	tween.tween_property($Line2D, "width", 3.0, 0.2)


func disapear() -> void:
	var tween = create_tween()
	tween.tween_property($Line2D, "width", 0, 0.1)

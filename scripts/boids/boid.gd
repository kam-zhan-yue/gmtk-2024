class_name Boid
extends Node2D

var velocity := Vector2.ZERO
var direction := Vector2.UP

var separation: Vector2
var alignment: Vector2
var cohesion: Vector2

func can_see(pos: Vector2) -> bool:
	var difference = (pos - global_position).length()
	return difference <= BoidManager.SETTINGS.vision_radius

func init() -> void:
	var min := BoidManager.SETTINGS.min_speed
	var max := BoidManager.SETTINGS.max_speed
	velocity = (min + max * 0.5) * direction.normalized()
	BoidManager.init(self)

func simulate() -> void:
	var separation_force := steer_towards(separation)
	var alignment_force := steer_towards(alignment)
	var cohesion_force := steer_towards(cohesion)
	var acceleration := Vector2.ZERO
	acceleration += separation_force * BoidManager.SETTINGS.separation_weight
	acceleration += alignment_force * BoidManager.SETTINGS.alignment_weight
	acceleration += cohesion_force * BoidManager.SETTINGS.cohesion_weight
	
	# Update the velocity by all forces
	velocity += acceleration * get_process_delta_time()
	
	# Clamp the velocity to a min and max speed
	var final_speed := clampf(velocity.length(), BoidManager.SETTINGS.min_speed, BoidManager.SETTINGS.max_speed)
	velocity = velocity.normalized() * final_speed
	global_position += velocity * get_process_delta_time()
	update_rotation()

func steer_towards(target: Vector2) -> Vector2:
	if target == Vector2.ZERO:
		return Vector2.ZERO
	var v := target.normalized() * BoidManager.SETTINGS.max_speed - velocity
	return v.clampf(-BoidManager.SETTINGS.max_steer_force, BoidManager.SETTINGS.max_steer_force)

func update_rotation() -> void:
	rotation = atan2(velocity.y, velocity.x) + PI * 0.5

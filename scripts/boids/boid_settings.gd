class_name BoidSettings
extends Resource

@export var min_speed := 70.0
@export var max_speed := 200.0
@export var max_steer_force := 100.0

@export var separation_weight := 1.0
@export var alignment_weight := 1.0
@export var cohesion_weight := 1.0
@export var obstacle_weight := 1.0
@export var avoidance_weight := 1.0

@export var separation := true
@export var alignment := true
@export var cohesion := true

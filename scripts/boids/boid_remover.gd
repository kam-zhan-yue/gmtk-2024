class_name BoidRemover
extends Node2D

func _on_area_2d_area_exited(area: Area2D) -> void:
	var parent = area.get_parent()
	if not parent:
		return
	var grandparent = parent.get_parent()
	if grandparent and grandparent is Boid:
		grandparent.uninit()

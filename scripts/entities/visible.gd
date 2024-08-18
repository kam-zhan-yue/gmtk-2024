class_name Visible
extends Area2D

func _on_area_entered(area: Area2D) -> void:
	var parent = area.get_parent()
	if parent and parent is Enemy:
		parent.activate_type()
		

func _on_area_exited(area: Area2D) -> void:
	var parent = area.get_parent()
	if parent and parent is Enemy:
		parent.deactivate_type()
	

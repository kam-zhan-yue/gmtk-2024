class_name Visible
extends Area2D



func _on_area_entered(area: Area2D) -> void:
	var parent = area.get_parent()
	if parent and parent is Enemy:
		print(str("Activate ", parent.name))
		parent.activate_type()
		

func _on_area_exited(area: Area2D) -> void:
	var parent = area.get_parent()
	if parent and parent is Enemy:
		print(str("Deactivate ", parent.name))
		parent.deactivate_type()
	

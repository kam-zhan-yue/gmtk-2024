extends Node

var spawn_node: Node2D

func _ready() -> void:
	spawn_node = Node2D.new()
	spawn_node.name = "Spawn Node"
	add_child(spawn_node)

func add_node(node: Node2D):
	spawn_node.add_child(node)

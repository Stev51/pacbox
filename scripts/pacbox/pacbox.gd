extends Node2D

func _ready() -> void:
	
	var viewport = get_viewport()
	viewport.physics_object_picking_first_only = false
	viewport.physics_object_picking_sort = true

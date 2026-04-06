extends Node2D

@onready var events = Events.new()

func _ready() -> void:
	
	var viewport = get_viewport()
	viewport.physics_object_picking_first_only = false
	viewport.physics_object_picking_sort = true

func enable() -> void:
	visible = true

func disable() -> void:
	visible = false

func call_event(id: String) -> void:
	events.call_event(id)

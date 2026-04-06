extends Node2D

@onready var events = Events.new()

@onready var room_node = $Room

func _ready() -> void:
	
	var viewport = get_viewport()
	viewport.physics_object_picking_first_only = false
	viewport.physics_object_picking_sort = true
	
	disable()

func start(room_id: String) -> void:
	if switch_room(room_id):
		enable()
	else:
		print("ERROR: PACBox not starting due to invalid room.")

func enable() -> void:
	visible = true

func disable() -> void:
	visible = false

func call_event(id: String) -> void:
	events.call_event(id)

func switch_room(id: String) -> bool:
	
	var path_name = "res://scenes/pacbox_rooms/" + id + ".tscn"
	
	if not ResourceLoader.exists(path_name):
		print("ERROR: Attempted to switch to a nonexistent room scene: " + path_name)
		return false
	
	var new_room = load(path_name).instantiate()
	
	for child in room_node.get_children():
		child.queue_free()
	
	room_node.add_child(new_room)
	
	return true

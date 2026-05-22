extends Node2D

@onready var events = Events.new()
@onready var flags = Flags.new()

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
		print("ERROR: PACBox not starting (invalid room ID).")

func enable() -> void:
	visible = true

func disable() -> void:
	visible = false

func call_event(id: String) -> void:
	events.call_event(id)

func get_flag(key: String) -> bool:
	if key in flags.flags:
		return flags.flags[key]
	else:
		print("ERROR: Accessed invalid story flag \"" + key + "\". Returning FALSE as a default value.")
		return false

# Returns true if flag already existed
func set_flag(key: String, val: bool = true) -> bool:
	var ret_val = (key in flags.flags)
	flags.flags[key] = val
	return ret_val

func fade_to_room(id: String) -> bool:
	
	FadeScreen.fade_out()
	await FadeScreen.fade_out_finished
	
	var result = switch_room(id)
	
	FadeScreen.fade_in()
	await FadeScreen.fade_in_finished
	
	return result

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

func queue_dialog(id: String) -> void:
	Dialogic.start(id)

func is_dialog_active() -> bool:
	return (Dialogic.current_timeline != null)

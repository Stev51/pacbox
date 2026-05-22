@tool
extends Node2D

enum DisplayMode {STILL_IMAGE, ANIMATED_IMAGE, HIDDEN_IMAGE}

@export var still_image: Texture2D
@export var animated_image: SpriteFrames
@export var display_mode: DisplayMode = DisplayMode.STILL_IMAGE
@export var hover_image: Texture2D
@export var hover_shape: Polygon2D
@export var hover_sound: AudioStream
@export var click_sound: AudioStream
@export var event_id: String = "DEFAULT"
@export var flag_id: String = ""

@onready var still_sprite_node = $StillImg
@onready var anim_sprite_node = $AnimImg
@onready var hover_sprite_node = $HoverImg
@onready var hover_shape_node = null
@onready var hover_sound_node = $HoverSound
@onready var click_sound_node = $ClickSound

var hoverable = true

func _ready() -> void:
	
	if not flag_id.is_empty():
		if not PACBox.get_flag(flag_id):
			visible = false
	
	still_sprite_node.texture = still_image
	anim_sprite_node.sprite_frames = animated_image
	hover_sprite_node.texture = hover_image
	
	if hover_shape != null:
		hover_shape_node = hover_shape
		hover_shape_node.visible = false
	
	hover_sound_node.stream = hover_sound
	click_sound_node.stream = click_sound
	
	update_display_mode(display_mode)

func update_display_mode(mode: DisplayMode) -> void:
	
	display_mode = mode
	
	match mode:
		DisplayMode.STILL_IMAGE:
			still_sprite_node.visible = true
			anim_sprite_node.visible = false
		DisplayMode.ANIMATED_IMAGE:
			still_sprite_node.visible = false
			anim_sprite_node.visible = true
		_:
			still_sprite_node.visible = false
			anim_sprite_node.visible = false

func call_event() -> void:
	PACBox.call_event(event_id)

func still_img() -> void:
	update_display_mode(DisplayMode.STILL_IMAGE)

func anim_img() -> void:
	update_display_mode(DisplayMode.ANIMATED_IMAGE)

func hide_img() -> void:
	update_display_mode(DisplayMode.HIDDEN_IMAGE)

func enable() -> void:
	visible = true

func disable() -> void:
	visible = false

func _on_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	# Left mouse button pressed
	if event is InputEventMouseButton and event.pressed and event.button_index == 1:
		if PACBox.hoverable:
			get_viewport().set_input_as_handled()
			click_sound_node.play()
			call_event()

func _on_mouse_entered() -> void:
	if not PACBox.is_dialog_active() and PACBox.hoverable:
		hover_sound_node.play()
		hover_sprite_node.visible = true
		if hover_shape_node != null:
			hover_shape_node.visible = true

func _on_mouse_exited() -> void:
	hover_sprite_node.visible = false
	if hover_shape_node != null:
		hover_shape_node.visible = false

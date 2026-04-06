@tool
extends Node2D

enum DisplayMode {STILL_IMAGE, ANIMATED_IMAGE, HIDDEN_IMAGE}

@export var still_image: Texture2D
@export var animated_image: SpriteFrames
@export var display_mode: DisplayMode = DisplayMode.STILL_IMAGE
@export var event_id: int = -1

@onready var still_sprite_node = $Sprite2D
@onready var anim_sprite_node = $AnimatedSprite2D

func _ready() -> void:
	
	still_sprite_node.texture = still_image
	anim_sprite_node.sprite_frames = animated_image
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

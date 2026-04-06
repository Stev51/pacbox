extends Node2D

@export var image: Texture2D

@onready var sprite_node = $Sprite2D

func _ready() -> void:
	
	if image != null:
		sprite_node.texture = image

extends CanvasLayer

signal fade_out_finished
signal fade_in_finished

@onready var color_rect = $ColorRect
@onready var anim_player = $AnimationPlayer

func _ready() -> void:
	color_rect.visible = false

func fade_out() -> void:
	color_rect.visible = true
	anim_player.play("fade_out")

func fade_in() -> void:
	anim_player.play("fade_in")
	await fade_in_finished
	color_rect.visible = false

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	match anim_name:
		"fade_out":
			fade_out_finished.emit()
		"fade_in":
			fade_in_finished.emit()

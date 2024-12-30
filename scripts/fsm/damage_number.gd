extends Node2D

@onready var animation_player = $AnimationPlayer
@onready var label = $Label

@export var random_width_range: float = 0.0
@export var vertical_offset: float = 20.0


func show_text(text: String, position: Vector2, color: Color = Color.WHITE):
	label.text = text
	label.modulate = color

	var random_offset_x = randf_range(-0.5 * random_width_range, 0.5 * random_width_range)
	global_position = position + Vector2(random_offset_x, -vertical_offset)
	
	animation_player.play("fly_out")


func show_damage(amount: int, position: Vector2, color: Color = Color.WHITE):
	label.text = str(amount)
	label.modulate = color

	var random_offset_x = randf_range(-0.5 * random_width_range, 0.5 * random_width_range)
	global_position = position + Vector2(random_offset_x, -vertical_offset)
	
	animation_player.play("fly_out")


func on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "fly_out":
		queue_free()

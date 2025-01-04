# effect.gd
class_name Effect
extends Node


@export var ttl: float = 4

@onready var anim: AnimatedSprite2D = $AnimatedSprite2D

var time: float = ttl


func _ready() -> void:
	anim.animation_finished.connect(on_animation_finished)


func _physics_process(delta: float) -> void:
	if time > 0:
		time -= delta
	else:
		queue_free()


func on_animation_finished() -> void:
	queue_free()

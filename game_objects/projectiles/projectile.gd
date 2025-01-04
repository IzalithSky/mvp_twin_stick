# projectile.gd
class_name Projectile
extends CharacterBody2D


@export var ttl: float = 4
@export var speed: float = 400

@onready var hitbox: Area2D = $Area2D

var time: float = ttl
var owner_char: Character


func _ready() -> void:
	hitbox.body_entered.connect(on_body_entered)


func _physics_process(delta: float) -> void:
	if time > 0:
		time -= delta
	else:
		queue_free()
		return
	
	velocity = Vector2(0, -speed).rotated(global_rotation)
	move_and_slide()


func on_body_entered(body: Node2D):
	pass

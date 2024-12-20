# character.gd
class_name Character
extends CharacterBody2D


@onready var anim : AnimatedSprite2D = $AnimatedSprite2D
@onready var fsm : StateMachine = $StateMachine
@onready var collider = $CollisionShape2D

var alive = true


func _ready() -> void:
	fsm.init()


func _physics_process(delta: float) -> void:
	fsm.process_physics(delta)


func kill():
	fsm.interrupt({"kill": null})

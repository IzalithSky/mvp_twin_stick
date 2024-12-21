# character.gd
class_name Character
extends CharacterBody2D


@export var max_hp: int = 1000
@export var stagger_dmg: int = 400

@onready var anim : AnimatedSprite2D = $AnimatedSprite2D
@onready var fsm : StateMachine = $StateMachine
@onready var collider = $CollisionShape2D

var alive = true
var hp: int


func _ready() -> void:
	hp = max_hp
	fsm.init()


func _physics_process(delta: float) -> void:
	fsm.process_physics(delta)


func take_damage(damage: int) -> void:
	hp -= damage
	
	if hp <= 0:
		kill()
		return
	
	if damage >= stagger_dmg:
		fsm.interrupt({"stagger": null})


func kill():
	fsm.interrupt({"kill": null})
	alive = false

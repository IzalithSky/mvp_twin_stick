# character.gd
class_name Character
extends CharacterBody2D


@export var max_hp: int = 1000
@export var stagger_dmg: int = 400

@onready var anim : AnimatedSprite2D = $AnimatedSprite2D
@onready var fsm : StateMachine = $StateMachine
@onready var collider = $CollisionShape2D
@onready var status_holer: StatusHolder = $StatusHolder
@onready var damage_controller: DamageController = $DamageController
@onready var hp_label: Label = $HPLabel


var alive = true
var hp: int


func _ready() -> void:
	hp = max_hp
	fsm.init()


func _physics_process(delta: float) -> void:
	fsm.process_physics(delta)
	status_holer.process_physics(delta)
	hp_label.text = str(hp)


func get_info() -> Dictionary:
	return {
		"name": name,
		"hp": hp,
		"max_hp": max_hp,
		"statuses": []
	}

func take_damage(damage: int) -> void:
	hp -= damage
	
	var damage_number = preload("res://scenes/damage_number.tscn").instantiate()
	get_parent().add_child(damage_number)
	damage_number.show_damage(damage, global_position, Color.ORANGE)
	
	if hp <= 0:
		kill()
		return
	
	if damage >= stagger_dmg:
		fsm.interrupt({"stagger": null})


func kill():
	fsm.interrupt({"kill": null})
	alive = false

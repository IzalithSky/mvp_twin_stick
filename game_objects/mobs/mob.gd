# mob.gd
class_name Mob
extends Character


@export var move_speed = 100
@export var attack_range = 60
@export var aggro_range = 200
@export var damage = 400

@onready var player: CharacterBody2D = get_tree().get_first_node_in_group("player")


func _physics_process(delta):
	super(delta)
	
	if not alive:
		return
	
	if velocity.x < 0:
		anim.flip_h = true
	else:
		anim.flip_h = false

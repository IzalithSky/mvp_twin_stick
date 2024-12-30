# mob_state_attack.gd
class_name MobStateAttack
extends CharacterState


@export var duration: float = 1

@onready var mob: Mob = character as Mob

var state_idle
var time: float


func _ready() -> void:
	super()
	
	for node in get_parent().get_children():
		if node is MobStateIdle:
			state_idle = node


func enter() -> void:
	time = duration
	character.anim.play("attack")


func process_physics(delta: float) -> State:
	if time <= 0:
		if mob.player.global_position.distance_to(mob.global_position) <= mob.attack_range:
			mob.player.damage_controller.take_damage(mob.damage)
		return state_idle
	
	time -= delta
	
	return null

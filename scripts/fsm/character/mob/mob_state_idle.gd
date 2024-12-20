# mob_state_idle.gd
class_name MobStateIdle
extends CharacterStateIdle


@onready var mob: Mob = character as Mob

var state_run
var state_attack


func _ready() -> void:
	super()
	
	for node in get_parent().get_children():
		if node is MobStateRun:
			state_run = node
		if node is MobStateAttack:
			state_attack = node


func process_physics(delta: float) -> State:
	if mob.global_position.distance_to(mob.player.global_position) <= mob.attack_range:
		return state_attack
	if mob.global_position.distance_to(mob.player.global_position) <= mob.aggro_range:
		return state_run
	return null

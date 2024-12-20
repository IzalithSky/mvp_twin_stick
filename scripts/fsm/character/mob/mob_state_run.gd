# mob_state_run.gd
class_name MobStateRun
extends CharacterStateRun


@onready var mob: Mob = character as Mob

var state_idle


func _ready() -> void:
	for node in get_parent().get_children():
		if node is MobStateIdle:
			state_idle = node


func process_physics(delta: float) -> State:
	if mob.player == null:
		return state_idle
	if mob.global_position.distance_to(mob.player.global_position) <= mob.attack_range:
		return state_idle
	if mob.global_position.distance_to(mob.player.global_position) > mob.aggro_range:
		return state_idle
	
	var dir_to_player = mob.global_position.direction_to(mob.player.global_position)
	mob.velocity = dir_to_player * mob.move_speed
	mob.move_and_slide()
	
	return null

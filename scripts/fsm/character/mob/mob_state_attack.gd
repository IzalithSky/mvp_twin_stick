# mob_state_attack.gd
class_name MobStateAttack
extends CharacterState


@export var duration: float = 1

@onready var mob: Mob = character as Mob

var state_idle
var time: float


func enter() -> void:
	character.anim.play("attack")
	time = duration


func _ready() -> void:
	for node in get_parent().get_children():
		if node is MobStateIdle:
			state_idle = node


func process_physics(delta: float) -> State:
	if time <= 0:
		if mob.player.global_position.distance_to(mob.global_position) <= mob.attack_range:
			mob.player.kill()
		return state_idle
	
	time -= delta
	
	return null

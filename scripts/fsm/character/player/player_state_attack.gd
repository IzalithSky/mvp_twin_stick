# player_state_attack.gd
class_name PlayerStateAttack
extends CharacterState


@onready var player: Player = character as Player

var state_idle
var time: float


func _ready() -> void:
	super()
	
	for node in get_parent().get_children():
		if node is PlayerStateIdle:
			state_idle = node


func enter() -> void:
	time = player.current_weapon.attack_duration
	character.anim.play("attack")
	player.current_weapon.attack()


func process_physics(delta: float) -> State:
	if time <= 0:
		return state_idle
	
	time -= delta
	
	return null

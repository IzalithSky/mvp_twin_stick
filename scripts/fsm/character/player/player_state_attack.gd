# player_state_attack.gd
class_name PlayerStateAttack
extends CharacterState


@export var duration: float = .25

@onready var player: Player = character as Player

var state_idle
var time: float


func _ready() -> void:
	super()
	
	for node in get_parent().get_children():
		if node is PlayerStateIdle:
			state_idle = node


func enter() -> void:
	time = duration
	character.anim.play("attack")
	player.shoot()


func process_physics(delta: float) -> State:
	if time <= 0:
		return state_idle
	
	time -= delta
	
	return null

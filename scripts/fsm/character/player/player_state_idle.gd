# player_state_idle.gd
class_name PlayerStateIdle
extends CharacterStateIdle


@onready var player: Player = character as Player

var state_run
var state_attack


func _ready() -> void:
	super()
	
	for node in get_parent().get_children():
		if node is PlayerStateAttack:
			state_attack = node
		if node is PlayerStateRun:
			state_run = node


func process_physics(delta: float) -> State:
	if Input.is_action_just_pressed("shoot") and player.current_weapon.is_ready:	
		return state_attack
	
	if Input.is_action_just_pressed("reload"):
		player.current_weapon.reload()
	
	if Input.get_vector("moveLeft", "moveRight", "moveUp", "moveDown") != Vector2.ZERO:
		return state_run
	
	return null

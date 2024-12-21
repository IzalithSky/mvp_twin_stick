# player_state_run.gd
class_name PlayerStateRun
extends CharacterStateRun


@onready var player: Player = character as Player

var state_idle
var state_attack


func _ready() -> void:
	super()
	
	for node in get_parent().get_children():
		if node is PlayerStateIdle:
			state_idle = node
		if node is PlayerStateAttack:
			state_attack = node


func process_physics(delta: float) -> State:
	if Input.is_action_just_pressed("shoot"):	
		return state_attack
	
	if Input.get_vector("moveLeft", "moveRight", "moveUp", "moveDown") == Vector2.ZERO:
		return state_idle
	
	player.velocity = player.move_speed * Input.get_vector("moveLeft", "moveRight", "moveUp", "moveDown")
	player.move_and_slide()
	
	return null

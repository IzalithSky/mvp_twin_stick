# character_state_stagger.gd
class_name CharacterStateStagger
extends CharacterState


@export var duration: float = .25

var state_idle
var time: float


func _ready() -> void:
	super()
	
	for node in get_parent().get_children():
		if node is CharacterStateIdle:
			state_idle = node


func enter() -> void:
	time = duration
	character.anim.play("stagger")


func process_physics(delta: float) -> State:
	if time <= 0:
		return state_idle
	
	time -= delta
	
	return null

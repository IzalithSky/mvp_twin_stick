# character_state.gd
class_name CharacterState
extends State


@onready var character: Character = get_parent().get_parent() as Character
@onready var fsm: StateMachine = get_parent() as StateMachine

var state_dead
var state_stagger


func _ready() -> void:
	for node in get_parent().get_children():
		if node is CharacterStateDead:
			state_dead = node
		if node is CharacterStateStagger:
			state_stagger = node


func interrupt(args: Dictionary) -> State:
	if args != null:
		if "kill" in args:
			return state_dead
		if "stagger" in args:
			return state_stagger
	
	return null

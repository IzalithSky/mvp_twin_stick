# character_state.gd
class_name CharacterState
extends State


@onready var character: Character = get_parent().get_parent() as Character
@onready var fsm: StateMachine = get_parent() as StateMachine

# state.gd
class_name State
extends Node


var state_name: String


func enter() -> void:
	pass


func process_input(event: InputEvent) -> State:
	return null


func process_physics(delta: float) -> State:
	return null


func exit() -> void:
	pass

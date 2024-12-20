# character_state_run.gd
class_name CharacterStateRun
extends CharacterState


func enter() -> void:
	character.anim.play("run")

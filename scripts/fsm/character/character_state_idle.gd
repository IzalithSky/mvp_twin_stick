# character_state_idle.gd
class_name CharacterStateIdle
extends CharacterState


func enter() -> void:
	character.anim.play("idle")

# character_state_dead.gd
class_name CharacterStateDead
extends CharacterState


func enter() -> void:
	character.anim.play("death")
	character.collider.disabled = true
	character.alive = false

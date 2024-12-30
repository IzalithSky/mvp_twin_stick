# damage_controller.gd
class_name DamageController
extends Node


@onready var character: Character = get_parent() as Character


func take_damage(amount: int) -> int:
	if "Evasion" in character.status_holer.statuses:
		var eval: float = character.status_holer.statuses["Evasion"].magnitude
		if eval > randf():
			return 0
	character.take_damage(amount)
	return amount

# damage_controller.gd
class_name DamageController
extends Node


@onready var character: Character = get_parent() as Character


func take_damage(amount: int) -> int:
	var damage_number = preload("res://scenes/damage_number.tscn").instantiate()
	character.get_parent().add_child(damage_number)
	
	if "Evasion" in character.status_holer.statuses:
		var eval: float = character.status_holer.statuses["Evasion"].magnitude
		if eval > randf():
			damage_number.show_text("Evaded", character.global_position, Color.SEA_GREEN)
			return 0
	
	character.take_damage(amount)
	damage_number.show_damage(amount, character.global_position, Color.ORANGE)
	
	return amount

# weapon_projectile.gd
class_name WeaponProjectile
extends Weapon


@export var projectile: PackedScene

@onready var owner_char: Player = get_parent()


func _attack() -> void:
	super()
	
	var p: Projectile = projectile.instantiate()
	get_tree().root.add_child(p)
	p.owner_char = owner_char
	p.global_position = owner_char.ray_cast_2d.global_position
	p.global_rotation = owner_char.ray_cast_2d.global_rotation

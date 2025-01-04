# player.gd
class_name Player
extends Character


@export var move_speed = 150

@onready var ray_cast_2d = $RayCast2D
@onready var current_weapon: Weapon = $WeaponHitscan
@onready var ammo_label: Label = $AmmoLabel


func _physics_process(delta: float) -> void:
	super(delta)
	
	ammo_label.text = str(current_weapon.ammo)
	
	if not alive:
		return
	
	ray_cast_2d.global_rotation = ray_cast_2d.global_position.direction_to(
		get_global_mouse_position()).angle() + PI / 2.0
	
	if global_position.x > get_global_mouse_position().x:
		anim.flip_h = true
	else:
		anim.flip_h = false

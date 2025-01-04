# player.gd
class_name Player
extends Character


@export var move_speed = 150

@onready var ray_cast_2d = $RayCast2D
@onready var weapon_hitscan: Weapon = $WeaponHitscan
@onready var weapon_projectile: Weapon = $WeaponProjectile
@onready var ammo_label: Label = $AmmoLabel

var current_weapon: Weapon


func _ready() -> void:
	super()
	current_weapon = weapon_hitscan


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("slot1"):
		current_weapon = weapon_hitscan
	if event.is_action_pressed("slot2"):
		current_weapon = weapon_projectile


func _physics_process(delta: float) -> void:
	super(delta)
	
	ammo_label.text = current_weapon.w_name \
		+ ": " \
		+ str(current_weapon.ammo) \
		+ (" +" if current_weapon.is_ready else " -")
	
	if not alive:
		return
	
	ray_cast_2d.global_rotation = ray_cast_2d.global_position.direction_to(
		get_global_mouse_position()).angle() + PI / 2.0
	
	if global_position.x > get_global_mouse_position().x:
		anim.flip_h = true
	else:
		anim.flip_h = false

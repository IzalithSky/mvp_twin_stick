# weapon.gd
class_name Weapon
extends Node


@export var maxammo: int = 1
@export var ammmo_per_reload: int = 1
@export var reload_duration: float = 1
@export var attack_duration: float = 1
@export var firerate: float = 1
@export var w_name: String

@onready var ammo: int = maxammo

var time: float
var is_ready: bool = true


func attack() -> void:
	if is_ready:
		is_ready = false
		if ammo > 0:
			ammo -= 1
			time = firerate
			_attack()


func _attack() -> void:
	pass


func reload() -> void:
	if ammo < maxammo:
		is_ready = false
		time = reload_duration
		ammo = min(maxammo,ammo + ammmo_per_reload)


func _physics_process(delta: float) -> void:
	if not is_ready:
		if time > 0:
			time -= delta
		elif ammo > 0:
			is_ready = true

# status_ignite.gd
class_name StatusIgnite
extends Status


var target: Character
var magnitude: int
var duration: float

var cap: int = 16384
var freq: int = 15

var current_dmg: int = 0
var time: float = 0
var ticks: int = 0


func init(target: Character, magnitude: int, duration: float) -> void:
	self.target = target
	self.magnitude = magnitude
	self.duration = duration
	
	status_name = "Ignite"


func enter() -> void:
	time = duration


func refresh() -> void:
	if not to_remove:
		time = duration


func process_physics(delta: float) -> void:
	if time <= 0:
		to_remove = true
		return
	
	time -= delta
	
	if ticks >= freq:
		apply_damage()
		ticks = 0
	
	ticks += 1


func apply_damage() -> void:
	if current_dmg < cap:
		current_dmg += magnitude
	else:
		current_dmg = cap
	
	target.take_damage(current_dmg)

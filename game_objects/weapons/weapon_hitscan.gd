# weapon_hitscan.gd
class_name WeaponHitscan
extends Weapon


@export var damage: int = 0
@export var tracer_duration = 0.05
@export var tracer_width = 2
@export var tracer_color = Color(1, 0.8, 0.2)

@onready var owner_char: Player = get_parent()


func _attack() -> void:	
	super()
	
	if owner_char.ray_cast_2d.is_colliding() and owner_char.ray_cast_2d.get_collider() is Character:
		var char = owner_char.ray_cast_2d.get_collider() as Character
		var hdmg = char.damage_controller.take_damage(damage)
		if hdmg > 0:
			var ignite = StatusIgnite.new()
			ignite.init(char, 20, 10)
			char.status_holer.add_status(ignite)
	
	create_tracer_effect()


func create_tracer_effect():
	var line = Line2D.new()
	line.width = tracer_width
	line.default_color = tracer_color
	line.gradient = create_tracer_gradient()
	get_tree().root.add_child(line)
	
	var start_point = owner_char.global_position
	var end_point = owner_char.get_global_mouse_position()
	
	line.add_point(start_point)
	line.add_point(end_point)
	
	delete_after_delay(line, tracer_duration)


func create_tracer_gradient() -> Gradient:
	var gradient = Gradient.new()
	
	gradient.set_color(0, Color(tracer_color.r, tracer_color.g, tracer_color.b, 1))
	gradient.set_color(1, Color(tracer_color.r, tracer_color.g, tracer_color.b, 0))
	return gradient


func delete_after_delay(node: Node, delay: float) -> void:
	await get_tree().create_timer(delay).timeout
	node.queue_free()

# player.gd
class_name Player
extends Character


@onready var ray_cast_2d = $RayCast2D
@export var move_speed = 150
@export var damage = 600
@export var tracer_duration = 0.05
@export var tracer_width = 2
@export var tracer_color = Color(1, 0.8, 0.2)


func _process(delta):
	if not alive:
		return
	
	ray_cast_2d.global_rotation = ray_cast_2d.global_position.direction_to(
		get_global_mouse_position()).angle() + PI / 2.0
	
	if global_position.x > get_global_mouse_position().x:
		anim.flip_h = true
	else:
		anim.flip_h = false


func shoot():	
	if ray_cast_2d.is_colliding() and ray_cast_2d.get_collider() is Character:
		var char = ray_cast_2d.get_collider() as Character
		char.take_damage(damage)
		var ignite = StatusIgnite.new()
		ignite.init(char, 2, 20)
		char.status_holer.add_status(ignite)
	
	create_tracer_effect()


func create_tracer_effect():
	var line = Line2D.new()
	line.width = tracer_width
	line.default_color = tracer_color
	line.gradient = create_tracer_gradient()
	get_tree().root.add_child(line)
	
	var start_point = global_position
	var end_point = get_global_mouse_position()
	
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

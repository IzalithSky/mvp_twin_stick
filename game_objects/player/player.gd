extends CharacterBody2D


@onready var ray_cast_2d = $RayCast2D
@export var move_speed = 200

var alive = true

func _process(delta):
	if not alive:
		return

	global_rotation = global_position.direction_to(get_global_mouse_position()).angle() + PI / 2.0
	
	if Input.is_action_just_pressed("shoot"):
		shoot()
		
func _physics_process(delta):
	if not alive:
		return
		
	var move_dir = Input.get_vector("moveLeft", "moveRight", "moveUp", "moveDown")
	velocity = move_dir * move_speed
	move_and_slide()
	
func kill():
	if not alive:
		return
	alive = false
	$graphics/dead.show()
	$graphics/alive.hide()
	z_index = -1
		
func shoot():
	$graphics/flash.show()
	$graphics/flash/Timer.start()
	
	if ray_cast_2d.is_colliding() and ray_cast_2d.get_collider().has_method("kill"):
		ray_cast_2d.get_collider().kill()

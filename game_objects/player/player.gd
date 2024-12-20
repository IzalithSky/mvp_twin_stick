extends Character


@onready var ray_cast_2d = $RayCast2D
@export var move_speed = 150

var alive = true


func _process(delta):
	if not alive:
		return
		
	ray_cast_2d.global_rotation = ray_cast_2d.global_position.direction_to(
		get_global_mouse_position()).angle() + PI / 2.0
	
	if Input.is_action_just_pressed("shoot"):
		shoot()
		
	if velocity != Vector2.ZERO:
		anim.play("run")
	else:
		anim.play("idle")
		
	if velocity.x < 0:
		anim.flip_h = true
	else:
		anim.flip_h = false


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
	anim.play("death")


func shoot():	
	if ray_cast_2d.is_colliding() and ray_cast_2d.get_collider().has_method("kill"):
		ray_cast_2d.get_collider().kill()

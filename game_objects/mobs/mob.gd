extends CharacterBody2D

@onready var ray_cast_2d = $RayCast2D
@export var move_speed = 100

@onready var player : CharacterBody2D = get_tree().get_first_node_in_group("player")

var alive = true

func _physics_process(delta):
	if not alive:
		return
		
	var dir_to_player = global_position.direction_to(player.global_position)
	velocity = dir_to_player * move_speed
	move_and_slide()
	
	global_rotation = dir_to_player.angle() + PI / 2.0
	
	if ray_cast_2d.is_colliding() and ray_cast_2d.get_collider() == player:
		player.kill()
	
func kill():
	if not alive:
		return
	alive = false
	$graphics/dead.show()
	$graphics/alive.hide()
	$CollisionShape2D.disabled = true
	z_index = -1

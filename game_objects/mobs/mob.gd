extends CharacterBody2D

@onready var ray_cast_2d = $RayCast2D
@export var move_speed = 100
@export var attack_range = 60

@onready var player : CharacterBody2D = get_tree().get_first_node_in_group("player")
@onready var anim : AnimatedSprite2D = $AnimatedSprite2D

var alive = true


func _ready() -> void:
	anim.play("run")


func _physics_process(delta):
	if not alive:
		return
		
	if player == null:
		return
		
	var dir_to_player = global_position.direction_to(player.global_position)
	velocity = dir_to_player * move_speed
	move_and_slide()
	
	if velocity.x < 0:
		anim.flip_h = true
	else:
		anim.flip_h = false
	
	#global_rotation = dir_to_player.angle() + PI / 2.0
	
	if global_position.distance_to(player.global_position) <= attack_range:
		anim.play("attack")
		player.kill()
	
func kill():
	if not alive:
		return
	alive = false
	$CollisionShape2D.disabled = true
	anim.play("death")

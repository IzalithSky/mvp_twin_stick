extends CanvasLayer

@onready var top_view = $TopView
@onready var shape_cast = $ShapeCast2D

var prev_mob_id = null

func _process(delta):
	var world_mouse_position = get_viewport().get_camera_2d().get_global_mouse_position()
	shape_cast.global_position = world_mouse_position
	if shape_cast.is_colliding():
		var mob = shape_cast.get_collider(0)
		if mob and mob.has_method("get_info"):
			var mob_info = mob.get_info()
			update_mob_info(mob.get_path() != prev_mob_id, mob_info.name, mob_info.hp, mob_info.max_hp, mob_info.statuses)
			prev_mob_id = mob.get_path()
		else:
			clear_mob_info()
	else:
		clear_mob_info()

func update_mob_info(refresh: bool, name: String, hp: float, max_hp: float, statuses: Array):
	$TopView/NameLabel.text = name
	if refresh:
		$TopView/hpbar.init_hp(max_hp)
	$TopView/hpbar.set_hp(hp, !refresh)
	top_view.visible = true

func clear_mob_info():
	top_view.visible = false

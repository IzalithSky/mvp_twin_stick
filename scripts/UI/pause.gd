extends Control


func _input(event: InputEvent):
	if event.is_action_pressed("menu"):
		on_resume_button_pressed()
		get_viewport().set_input_as_handled()


func on_resume_button_pressed():
	get_tree().paused = false
	queue_free()


func on_button_settings_pressed():
	var settings_scene = preload("res://scenes/settings.tscn").instantiate()
	add_child(settings_scene)


func on_menu_button_pressed():
	get_tree().paused = false
	queue_free()
	get_tree().change_scene_to_file("res://scenes/screen_main_menu.tscn")

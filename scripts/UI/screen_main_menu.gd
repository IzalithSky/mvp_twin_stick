extends Node2D


func on_button_play_pressed():
	get_tree().change_scene_to_file("res://scenes/level_0.tscn")


func on_button_settings_pressed():
	var settings_scene = preload("res://scenes/settings.tscn").instantiate()
	add_child(settings_scene)


func on_button_exit_pressed():
	get_tree().quit()

extends Node2D

var pause_menu_scene = preload("res://scenes/pause.tscn")
var pause_menu: Control


func _input(event: InputEvent):
	if event.is_action_pressed("menu"):
		toggle_pause()


func toggle_pause():
	if get_tree().paused:
		get_tree().paused = false
		if pause_menu:
			pause_menu.queue_free()
			pause_menu = null
	else:
		get_tree().paused = true
		pause_menu = pause_menu_scene.instantiate()
		get_tree().get_root().add_child(pause_menu)
		pause_menu.grab_focus()

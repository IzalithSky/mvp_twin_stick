extends Control

@onready var back_button = $BackButton
@onready var player1_action_list = $ScrollContainer/MarginContainer/SettingsContainer/P1ActionList
@onready var player2_action_list = $ScrollContainer/MarginContainer/SettingsContainer/P2ActionList
@onready var fullscreen_checkbox = $ScrollContainer/MarginContainer/SettingsContainer/FullscreenCheckBox
@onready var mobile_controls_checkbox = $ScrollContainer/MarginContainer/SettingsContainer/MobileCheckBox

@onready var music_volume_slider = $ScrollContainer/MarginContainer/SettingsContainer/MusicContainer/MusicSlider
@onready var sfx_volume_slider = $ScrollContainer/MarginContainer/SettingsContainer/SFXContainer/SFXSlider

@onready var input_button_scene = preload("res://scenes/settings_input_buttons.tscn")

var is_remapping = false
var action_to_remap = null
var event_to_remap = null
var remapping_button = null

func _ready():
	back_button.grab_focus()
	fullscreen_checkbox.button_pressed = ConfigHandler.load_settings("video").fullscreen
	mobile_controls_checkbox.button_pressed = ConfigHandler.load_settings("video").mobile_controls
	var audio_settings = ConfigHandler.load_settings("audio")
	music_volume_slider.value = min(audio_settings.music_volume, 1.0) * 100
	sfx_volume_slider.value = min(audio_settings.sfx_volume, 1.0) * 100
	create_action_list()
		
func create_action_list():
	ConfigHandler.apply_keybindings_from_settings()
	fill_action_list(player1_action_list)
	
func fill_action_list(action_list: Control):
	for item in action_list.get_children():
		item.queue_free()
	
	for action in ConfigHandler.input_actions:
		var button = input_button_scene.instantiate()
		var action_label = button.find_child("LabelAction")
		var input_button1 = button.find_child("Button1")
		var input_button2 = button.find_child("Button2")
		
		action_label.text = ConfigHandler.input_actions[action]
		var events = InputMap.action_get_events(action)
		var event1 = null
		if events.size() > 0:
			event1 = events[0]
			input_button1.text = format_event_name(events[0])
		else:
			input_button1.text = ""
		
		var event2 = null
		if events.size() > 1:
			event2 = events[1]
			input_button2.text = format_event_name(events[1])
		else:
			input_button2.text = ""
		action_list.add_child(button)
		input_button1.pressed.connect(on_input_button_pressed.bind(action, event1, input_button1))
		input_button2.pressed.connect(on_input_button_pressed.bind(action, event2, input_button2))
	
func on_input_button_pressed(action, event, clicked_button):
	if !is_remapping:
		is_remapping = true
		action_to_remap = action
		event_to_remap = event
		remapping_button = clicked_button
		clicked_button.text = "Press key to bind.."
		
func _input(event: InputEvent):
	if is_remapping:
		if event is InputEventKey:
			if event.is_action_pressed("ui_cancel"):
				if event_to_remap == null:
					remapping_button.text = ""
				else: 
					remapping_button.text = format_event_name(event_to_remap)
			else:
				InputMap.action_erase_event(action_to_remap, event_to_remap)
				InputMap.action_add_event(action_to_remap, event)
				ConfigHandler.replace_keybinding(action_to_remap, event_to_remap, event)
				remapping_button.text = format_event_name(event)
			
			is_remapping = false
			action_to_remap = null
			event_to_remap = null
			remapping_button = null
			accept_event()
			
	elif event.is_action_pressed("ui_cancel"):
		close_scene()

func format_event_name(event: InputEvent) -> String:
	var name = event.as_text()
	if event is InputEventJoypadButton:
		name = name.trim_suffix(")")
		return name.trim_prefix("Joypad Button " + str(event.button_index) + " (")
	return name.trim_suffix(" (Physical)")

func _on_back_button_pressed():
	close_scene()

func close_scene():
	queue_free() 

func on_reset_button_pressed():
	ConfigHandler.set_default_keybindings()
	create_action_list()


func on_fullscreen_check_box_toggled(toggled_on: bool):
	ConfigHandler.save_setting("video", "fullscreen", toggled_on)
	ConfigHandler.apply_video_settings()

func on_music_slider_value_changed(value: float) -> void:
	ConfigHandler.save_setting("audio", "music_volume", music_volume_slider.value / 100)
	ConfigHandler.apply_audio_settings()


func on_sfx_slider_value_changed(value: float) -> void:
	ConfigHandler.save_setting("audio", "sfx_volume", sfx_volume_slider.value / 100)
	ConfigHandler.apply_audio_settings()


func on_mobile_check_box_toggled(toggled_on: bool) -> void:
	ConfigHandler.save_setting("video", "mobile_controls", toggled_on)

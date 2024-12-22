extends Node

const SETTINGS_FILE_PATH = "user://config.ini"
var config = ConfigFile.new()
var min_db = -80.0  # Minimum dB (mute)
var max_db = 0.0    # Maximum dB (full volume)

var input_actions = {
	"moveUp": "Move up",
	"moveDown": "Move down",
	"moveLeft": "Move left",
	"moveRight": "Move right",
	"shoot": "shoot",
}

func _ready():
	if !FileAccess.file_exists(SETTINGS_FILE_PATH):
		config.set_value("video", "fullscreen", true)
		config.set_value("video", "mobile_controls", false)
		config.set_value("audio", "music_volume", 1.0) 
		config.set_value("audio", "sfx_volume", 1.0) 
		set_default_keybindings()
	else:
		config.load(SETTINGS_FILE_PATH)
		
	apply_keybindings_from_settings()
	apply_video_settings()
	apply_audio_settings()
	
func apply_keybindings_from_settings():
	var keybindings = load_keybindings()
	for action in keybindings.keys():
		InputMap.action_erase_events(action)
		var events = keybindings[action]
		for event in events:
			InputMap.action_add_event(action, event)

func apply_video_settings():
	var fullscreen = load_settings("video").fullscreen
	if fullscreen:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_MAXIMIZED)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)

func apply_audio_settings():
	var audio_settings = ConfigHandler.load_settings("audio")
	var music_volume = min(audio_settings.music_volume, 1.0)
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"), linear_to_db(music_volume))

	var sfx_volume = min(audio_settings.sfx_volume, 1.0)
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), linear_to_db(sfx_volume))

func linear_to_db(linear_value: float) -> float:
	return lerp(min_db, max_db, linear_value)

func save_setting(section: String, key: String, value):
	config.set_value(section, key, value)
	config.save(SETTINGS_FILE_PATH)

func load_settings(section: String):
	var video_settings = {}
	for key in config.get_section_keys (section):
		video_settings[key] = config.get_value(section, key)
	return video_settings
	
func set_default_keybindings():
	InputMap.load_from_project_settings()
	for action in input_actions:
		var action_name = action
		clear_keybinding(action_name)
		var events = InputMap.action_get_events(action_name)
		for event in events:
			save_keybinding(action_name, event)
		
	config.save(SETTINGS_FILE_PATH)

func save_keybinding(action: StringName, event: InputEvent):
	var event_str = event_to_string(event)

	var keybinding_array = config.get_value("keybinding", action, [])
	keybinding_array.append(event_str)

	config.set_value("keybinding", action, keybinding_array)
	config.save(SETTINGS_FILE_PATH)

func load_keybindings():
	var keybindings = {}
	var keys = config.get_section_keys("keybinding")
	
	for key in keys:
		var event_str_array = config.get_value("keybinding", key, [])
		var input_events = []
		for event_str in event_str_array:
			var input_event
			
			if event_str.contains("mouse_"):
				input_event = InputEventMouseButton.new()
				input_event.button_index = int(event_str.split("_")[1])
			elif event_str.contains("joypad_"):
				input_event = InputEventJoypadButton.new()
				input_event.button_index = int(event_str.split("_")[1])
			else:
				input_event = InputEventKey.new()
				input_event.keycode = OS.find_keycode_from_string(event_str)
				
			input_events.append(input_event)
			
		keybindings[key] = input_events
	return keybindings
	
func replace_keybinding(action: StringName, old_event: InputEvent, new_event: InputEvent):
	var keybinding_array = config.get_value("keybinding", action, [])
	var old_event_str = event_to_string(old_event)
	var new_event_str = event_to_string(new_event)

	var index = keybinding_array.find(old_event_str)
	if index != -1:
		keybinding_array[index] = new_event_str
	else:
		keybinding_array.append(new_event_str)
	config.set_value("keybinding", action, keybinding_array)
	config.save(SETTINGS_FILE_PATH)

func event_to_string(event: InputEvent) -> String:
	if event is InputEventKey:
		var event_keycode = max(event.keycode, event.physical_keycode)
		return OS.get_keycode_string(event_keycode)
	elif event is InputEventMouseButton:
		return "mouse_" + str(event.button_index)
	elif event is InputEventJoypadButton:
		return "joypad_" + str(event.button_index)
	return ""

func clear_keybinding(action: StringName):
	config.set_value("keybinding", action, [])
	config.save(SETTINGS_FILE_PATH)

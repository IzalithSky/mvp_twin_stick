extends ProgressBar

@onready var timer = $Timer
@onready var dmgbar = $dmgbar

@export var timer_duration: float = 0.5

var current_hp = 0

func _ready():
	timer.wait_time = timer_duration

func set_hp(new_hp_value: int, show_damage: bool):
	if new_hp_value == current_hp:
		return
	handle_damage(current_hp, new_hp_value, show_damage)
	current_hp = min(max_value, new_hp_value)
	value = current_hp

func handle_damage(previous_hp: int, new_hp_value: int, show_damage: bool):
	if new_hp_value < previous_hp and show_damage:
		dmgbar.value = previous_hp
		timer.start()
	else:
		dmgbar.value = new_hp_value

func init_hp(initial_hp: int, initial_max_hp: int = -1):
	max_value = initial_max_hp if initial_max_hp > 0 else initial_hp
	current_hp = initial_hp
	value = current_hp
	dmgbar.max_value = max_value
	dmgbar.value = current_hp

func reset_hp():
	current_hp = max_value
	value = current_hp
	dmgbar.value = current_hp

func _on_timer_timeout():
	dmgbar.value = current_hp

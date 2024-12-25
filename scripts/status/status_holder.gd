# status_holder.gd
class_name StatusHolder
extends Node


var statuses: Dictionary


func add_status(status: Status) -> void:
	if status.status_name not in statuses:
		statuses[status.status_name] = status
		statuses[status.status_name].enter()
	else:
		statuses[status.status_name].refresh()


func process_physics(delta: float) -> void:
	for status_name in statuses:
		statuses[status_name].process_physics(delta)
		if statuses[status_name].to_remove:
			statuses[status_name].exit()
			statuses.erase(status_name)

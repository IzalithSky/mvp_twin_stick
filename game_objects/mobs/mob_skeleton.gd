# mob_skeleton.gd
class_name MobSkeleton
extends Mob


func _ready() -> void:
	super()
	var evasion = StatusEvasion.new()
	evasion.init(.5)
	status_holer.add_status(evasion)

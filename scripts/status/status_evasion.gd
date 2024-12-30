# status_evasion.gd
class_name StatusEvasion
extends Status


var magnitude: float


func init(magnitude: float) -> void:
	self.magnitude = magnitude
	
	status_name = "Evasion"

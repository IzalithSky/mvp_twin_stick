# projectile_flare.gd
class_name ProjectileFlare
extends Projectile


@export var damage: int = 50
@export var ignite_base_damage: int = 20
@export var ignite_duration: float = 10
@export var effect: PackedScene


func on_body_entered(body: Node2D):
	super(body)
	
	if body is Character:
		var char = body as Character
		if char != owner_char:
			var hdmg = char.damage_controller.take_damage(damage)
			if hdmg > 0:
				var ignite = StatusIgnite.new()
				ignite.init(char, ignite_base_damage, ignite_duration)
				char.status_holer.add_status(ignite)
				
				var e = effect.instantiate()
				get_tree().root.add_child(e)
				e.transform = transform
				
				queue_free()

extends "res://weapons/abstract/Weapon.gd"

export(float) var AllowedFiringDistance = 80
export(PackedScene) var Bullet
 
var item_id = "gun"

func attack(_body):
	if can_attack(_body):
		var b = Bullet.instance()
		b.direction = (get_global_mouse_position() - global_position).normalized()
		b.position = global_position
		get_tree().current_scene.add_child(b)
	
		.attack(_body)

func can_attack(_body):
	return .can_attack(_body) and \
		not (get_global_mouse_position().distance_to(global_position) \
		< AllowedFiringDistance)
	

extends "res://weapons/abstract/Weapon.gd"

export(float) var AllowedFiringDistance = 80
export(PackedScene) var Bullet
export(PackedScene) var BangSound

const MuzzleLength = 25

var item_id = "gun"

func attack(_body):
	if can_attack(_body):
		var b = Bullet.instance()
		b.direction = (get_global_mouse_position() \
			 - global_position).normalized()
		b.position = global_position \
			+ b.direction * MuzzleLength
		get_tree().current_scene.add_child(b)
		bang()
		.attack(_body)

func can_attack(_body):
	return .can_attack(_body) and \
		not (get_global_mouse_position().distance_to(global_position) \
		< AllowedFiringDistance)
	
func bang():
	var bang = BangSound.instance()
	bang.play()
	add_child(bang)
	
	var lifespan = get_tree().create_timer(\
		bang.stream.get_length())
	lifespan.connect("timeout", bang, "queue_free")

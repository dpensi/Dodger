extends RigidBody2D

export(float) var AllowedFiringDistance = 80
export(PackedScene) var Bullet
 
var item_id = "gun"

func fire():
	if get_global_mouse_position().distance_to(global_position) \
		< AllowedFiringDistance:
		print("aiming too close!")
		return
		
	var b = Bullet.instance()
	b.direction = (get_global_mouse_position() - global_position).normalized()
	b.position = global_position
	get_tree().current_scene.add_child(b)

extends Area2D

export(float) var Speed = 1000
export(int) var Damage = 1

var direction

func _process(delta):
	position += direction * Speed * delta 
	rotation = direction.angle()
	
func _on_Bullet_body_entered(body):
	if body.is_in_group("damageable"):
		body.get_damage(self)
	
	queue_free()

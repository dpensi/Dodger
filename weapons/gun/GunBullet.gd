extends KinematicBody2D

export(float) var Speed = 1000
export(int) var Damage = 1

var direction
var velocity = Vector2.ZERO

func _physics_process(_delta):
	rotation = direction.angle()
	velocity = lerp(velocity, direction.normalized() * Speed, 0.9)
	velocity = move_and_slide(velocity)
	
func _on_Bullet_body_entered(body):
	if body.is_in_group("damageable"):
		body.get_damage(self)
	
	queue_free()

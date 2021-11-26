extends "res://weapons/abstract/Weapon.gd"

export(int) var Damage = 2

onready var claws_area = get_node("ClawsArea")

func _on_ClawsArea_body_entered(body):
	if can_attack(body):
		attack(body)

func _on_AttackCooldownTimer_timeout():
	._on_AttackCooldownTimer_timeout()
	for b in claws_area.get_overlapping_bodies():
		if can_attack(b):
			attack(b)
			
func can_attack(body):
	return body != get_parent() and \
		body.is_in_group("damageable") and \
		.can_attack(body)

func attack(body):
	if can_attack(body):
		body.get_damage(self)
		.attack(body)




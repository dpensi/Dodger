extends "res://characters/abstract/Character.gd"

export(NodePath) var PathRef
export(int) var Damage = 2
export(float) var AttackCooldownTime = 0.5 

onready var attack_cooldown_timer = get_node("AttackCooldownTimer")
onready var claws = get_node("Claws")

var cooldown = false

func _ready():
	._ready()
	
	Controller.patrol_follow = get_node(PathRef)
	Controller.FollowingDistance = 0
	attack_cooldown_timer.wait_time = AttackCooldownTime

func _on_Claws_body_entered(body):
	if can_attack(body):
		attack_procedure(body)
			
func _on_AttackCooldownTimer_timeout():
	cooldown = false
	for b in claws.get_overlapping_bodies():
		if can_attack(b):
			attack_procedure(b)
			
func can_attack(body):
	return body != self and \
		body.is_in_group("damageable") and \
		not cooldown

func attack_procedure(body):
	body.get_damage(self)
	cooldown = true
	attack_cooldown_timer.start()
	
func animate():
	.animate()
	# raise hands when attacking
	for b in claws.get_overlapping_bodies():
		if b != self and b.is_in_group("damageable"):
			$AnimatedSprite.animation = "run"
			$AnimatedSprite.play()
			break

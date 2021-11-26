extends RigidBody2D

export(float) var AttackCooldownTime = 0.5 

onready var attack_cooldown_timer = get_node("AttackCooldownTimer")

var cooldown = false

func _ready():
	attack_cooldown_timer.wait_time = AttackCooldownTime

func _on_AttackCooldownTimer_timeout():
	cooldown = false

func can_attack(_body):
	return not cooldown
	
func attack(_body):
	cooldown = true
	attack_cooldown_timer.start()

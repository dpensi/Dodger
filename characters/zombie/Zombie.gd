extends "res://characters/abstract/Character.gd"

export(NodePath) var Navigation
export(Array, Vector2) var PatrolPoints

var claws_area

func _ready():	
	Controller.PatrolPoints = PatrolPoints
	Controller.Navigation = "../" + Navigation
	
	in_hand = load("res://weapons/claws/Claws.tscn").instance()
	claws_area = in_hand.get_node("ClawsArea")
	add_child(in_hand)
	
func animate():
	.animate()
	# raise hands when attacking
	for b in claws_area.get_overlapping_bodies():
		if b != self and b.is_in_group("damageable"):
			$AnimatedSprite.animation = "run"
			$AnimatedSprite.play()
			break

extends "res://controllers/AbstractController.gd"

export(int) var OffsetJump = 30
export(NodePath) var PatrolPath

onready var patrol_follow : PathFollow2D

func think(_delta):
	direction = (patrol_follow.global_position - \
		character.global_position).normalized()
	
	if character.global_position.\
		distance_to(patrol_follow.global_position) < 50:
		patrol_follow.offset += OffsetJump

func do():
	character.walk()
	character.look_at(patrol_follow.global_position)

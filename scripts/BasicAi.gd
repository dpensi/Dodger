extends "res://scripts/AbstractController.gd"

export(int) var OffsetJump = 10

func think(_delta):
	direction = ( character.patrol_follow.position - character.position ).normalized()
	points_to = character.patrol_follow.position
	
	if character.position.distance_to(character.patrol_follow.position) < 50:
		character.patrol_follow.offset += OffsetJump

func do():
	character.walk()
	character.look_at(character.patrol_follow.position)

extends "res://scripts/AbstractController.gd"

export(PackedScene) var Patrol 
export(int) var OffsetJump = 10

var patrol_follow : PathFollow2D
func _ready():
	var patrol_inst = Patrol.instance()
	get_tree().root.get_child(0).call_deferred("add_child", patrol_inst)
	patrol_follow = patrol_inst.get_child(0)

func think(_delta):
	direction = ( patrol_follow.position - character.position ).normalized()
	points_to = patrol_follow.position
	
	if character.position.distance_to(patrol_follow.position) < 50:
		patrol_follow.offset += OffsetJump

func do():
	character.walk()
	character.look_at(patrol_follow.position)

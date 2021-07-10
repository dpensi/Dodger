extends "res://scripts/AbstractController.gd"

export(PackedScene) var Patrol 
export(int) var WalkSpeed = 200
export(int) var OffsetJump = 10

var patrol_follow : PathFollow2D
func _ready():
	var patrol_inst = Patrol.instance()
	get_tree().root.get_child(0).call_deferred("add_child", patrol_inst)
	patrol_follow = patrol_inst.get_child(0)

func get_input(_delta):
	direction = ( patrol_follow.position - get_parent().position ).normalized()
	points_to = patrol_follow.position
	patrol_follow.set_offset(patrol_follow.get_offset() + OffsetJump)

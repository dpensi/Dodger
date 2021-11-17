extends "res://characters/abstract/Character.gd"

export(NodePath) var PathRef

func _ready():
	._ready()
	Controller.patrol_follow = get_node(PathRef)


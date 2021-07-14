extends "res://scripts/BasicAi.gd"

var can_chase # TODO: not a single body but a list of body!
export var FollowingDistance = 250

func _ready():
	._ready()
	character.get_node("FieldOfView").connect("body_entered", self, "_on_FieldOfView_body_entered")
	character.get_node("FieldOfView").connect("body_exited", self, "_on_FieldOfView_body_exited")


func think(_delta):
	if not can_chase:
		.think(_delta)
	else:
		direction = ( can_chase.position - character.position ).normalized()
		points_to = can_chase.position
	
func do():
	if can_chase: 
		print(character.position.distance_to(can_chase.position))
	if not can_chase:
		.do()
	elif character.position.distance_to(can_chase.position) > FollowingDistance:
		character.run()
		character.look_at(can_chase.position)
	else:
		character.wait()
		character.look_at(can_chase.position)

func _on_FieldOfView_body_entered(body):
	print("ready to chase") 
	can_chase = body
	print(body.name)

func _on_FieldOfView_body_exited(_body):
	print("nothing to chase")
	can_chase = null

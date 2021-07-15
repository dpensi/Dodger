extends "res://scripts/BasicAi.gd"

var bodies_in_view = []
export var FollowingDistance = 250

func _ready():
	._ready()
	character.get_node("FieldOfView").connect("body_entered", self, "_on_FieldOfView_body_entered")
	character.get_node("FieldOfView").connect("body_exited", self, "_on_FieldOfView_body_exited")


func think(_delta):
	if not bodies_in_view:
		.think(_delta)
	else:
		direction = ( bodies_in_view[0].position - character.position ).normalized()
		points_to = bodies_in_view[0].position
	
func do():
	if not bodies_in_view:
		.do()
	elif character.position.distance_to(bodies_in_view[0].position) > FollowingDistance:
		character.run()
		character.look_at(bodies_in_view[0].position)
	else:
		character.wait()
		character.look_at(bodies_in_view[0].position)

func _on_FieldOfView_body_entered(body):
	if body == character: 
		return # don't chase yourself
	
	bodies_in_view.append(body)
	print("I can see: ", bodies_in_view)

func _on_FieldOfView_body_exited(body):
	bodies_in_view.erase(body)
	print("I can see: ", bodies_in_view)

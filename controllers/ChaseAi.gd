extends "res://controllers/BasicAi.gd"

# FollowingDistance for melee attacks set 0, set
# higher value to stop at a distance from targer
export var FollowingDistance = 250
export var BlinkTime = 0.5

var bodies_in_area = [] # bodies in area2d
var bodies_in_view = [] # bodies that I can actually see

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
	bodies_in_area.append(body)


func _on_FieldOfView_body_exited(body):
	bodies_in_area.erase(body)
	bodies_in_view.erase(body)

func _on_Blink_timeout():
	for body in bodies_in_area:
		var dss = character.get_world_2d().direct_space_state 
		var intersection = dss.intersect_ray(
				character.position, body.position, [character])
		if not intersection.collider.is_in_group("buildings"):
			if not bodies_in_view.has(body):
				bodies_in_view.append(body)
		else:
			bodies_in_view.erase(body)
	# print("bodies in view: ", bodies_in_view) 

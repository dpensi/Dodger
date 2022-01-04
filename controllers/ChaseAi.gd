extends "res://controllers/PatrolAi.gd"

# FollowingDistance for melee attacks set 0, set
# higher value to stop at a distance from targer
export var FollowingDistance = 0
export var BlinkTime = 0.5

var bodies_in_area = [] # bodies in area2d
var bodies_in_view = [] # bodies that I can actually see
var track_path = [] # TODO is this var really necessary?

func _ready():
	character.get_node("FieldOfView").connect(\
		"body_entered", self, "_on_FieldOfView_body_entered")
	character.get_node("FieldOfView").connect(\
		"body_exited", self, "_on_FieldOfView_body_exited")

func think(_delta):
	if not bodies_in_view:
		.think(_delta)
	else:
		track(bodies_in_view[0].global_position)

func do():
	if not bodies_in_view:
		.do()
	elif character.position.distance_to(\
		bodies_in_view[0].position) > FollowingDistance:
		character.run()
	else:
		character.wait()

func track(target_pos):
	if not track_path:
		track_path = navigation.get_walking_path( \
			character.global_position, \
			target_pos)
		current_path = track_path
	else:
		if utils.v3_to_v2(track_path[-1]).\
			distance_to(target_pos) >\
			navigation.pavement.cell_size.x:
			
			track_path.append(utils.v2_to_v3(target_pos))
			current_path = track_path
	follow_current_path()
	track_path = current_path
	character.look_at(target_pos)

func _on_FieldOfView_body_entered(body):
	if body == character: 
		return # don't chase yourself
	bodies_in_area.append(body)

func _on_FieldOfView_body_exited(body):
	bodies_in_area.erase(body)
	bodies_in_view.erase(body)
	if not bodies_in_view and track_path:
		track_path = []
		current_path = []

func _on_Blink_timeout():
	for body in bodies_in_area:
		var dss = character.get_world_2d().direct_space_state 
		var intersection = dss.intersect_ray(
				character.position, body.position, [character])
		if intersection.size() > 0 and \
			not intersection.collider.is_in_group("buildings"):
			
			if not bodies_in_view.has(body):
				bodies_in_view.append(body)
		else:
			bodies_in_view.erase(body)

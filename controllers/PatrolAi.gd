extends "res://controllers/AbstractController.gd"

export(Array, Vector2) var PatrolPoints
export(NodePath) var Navigation

var utils = load("res://scripts/Utils.gd").new()
var current_path = []
var current_patrol_point = 0
 
onready var path_point = character.global_position
onready var navigation = get_node(Navigation)

func think(_delta):
	if not navigation:
		push_error("navigation not set, will try again")
		navigation = get_node(Navigation)
		return

	if utils.v2_almost_eq( \
		PatrolPoints[current_patrol_point],
		character.global_position, navigation.pavement.cell_size.x):
		
		next_patrol_point()
		current_path = []
		
	follow_current_path()

func do():
	character.walk()
	character.look_at(path_point)

func follow_current_path():
	if not current_path:
		current_path = navigation.get_walking_path( \
			character.global_position, \
			PatrolPoints[current_patrol_point])
		if not current_path:
			handle_non_existing_path()
			return

	if utils.v2_almost_eq(path_point, character.global_position, 5):
		next_path_point()
	
	direction = (path_point - character.global_position).normalized()

func next_patrol_point():
	current_patrol_point += 1
	current_patrol_point %= PatrolPoints.size()

func next_path_point():
	path_point = utils.v3_to_v2(current_path[0])
	current_path.remove(0)

func handle_non_existing_path():
	push_error("point " + str(PatrolPoints[current_patrol_point]) \
		+ " not reachable, trying next one")
	next_patrol_point()

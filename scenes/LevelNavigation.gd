extends Node

export(NodePath) var PavementTileMap
export(int) var WallAvoidance = 15

var utils = load("res://scripts/Utils.gd").new()
var astar = AStar.new()
# stores tile position -> astar node id
var position_id_map = {}

onready var pavement = get_node(PavementTileMap)
onready var tile_center_offset = (pavement.cell_size / 2)

func _ready():
	init_astar()

func init_astar():
	var tile_position 		# tile global position
	var neighbor_position 	# neighbor global position

	for cell_xy in pavement.get_used_cells():
		if is_walkable(cell_xy):
			tile_position = get_tile_global_position(cell_xy)
			astar_add_point(cell_xy, tile_position)
		else: continue
		
		for neighbor in get_adjacent_cells(cell_xy):
			if is_walkable(neighbor):
				neighbor_position = get_tile_global_position(neighbor)
				astar_add_point(neighbor, neighbor_position)
			
				if not astar.are_points_connected(\
					position_id_map[cell_xy],
					position_id_map[neighbor]):
					
					astar.connect_points(\
						position_id_map[cell_xy], \
						position_id_map[neighbor]) 

func get_adjacent_cells(cell_xy):
	var adjacents = []
	for x in [-1, 0, 1]:
		for y in [-1, 0, 1]:
			if x == 0  and y == 0: continue
			adjacents.append( \
				Vector2(cell_xy.x + x , cell_xy.y + y))
	return adjacents

func astar_add_point(cell_xy, global_position):
	if not position_id_map.has(cell_xy):
		position_id_map[cell_xy] = astar.get_available_point_id()
		astar.add_point(astar.get_available_point_id(), \
			Vector3(global_position.x, global_position.y, 0))
		
func is_walkable(cell_xy):
	return not pavement.get_cellv(cell_xy) == pavement.INVALID_CELL and \
		not pavement.tile_set.tile_get_shapes(pavement.get_cellv(cell_xy))
	
# returns the position of a tile in world coordinates
# if center is true returns the center of the tile,	
# will return the top-left corner otherwise
func get_tile_global_position(cell_xy, center = true):
	return (pavement.map_to_world(cell_xy) + \
		tile_center_offset if center else Vector2.ZERO)

func get_simple_path(start, goal):
	var start_id = position_id_map[pavement.world_to_map(start)]
	var goal_id = position_id_map[pavement.world_to_map(goal)]
	var path = astar.get_point_path(start_id, goal_id)
	return path

# this path avoids walls, and corner
func get_walking_path(start, goal):
	var path = get_simple_path(start, goal)
	
	var i = 0
	var point_xy
	var up = Vector2(0, -1)
	var down = Vector2(0, 1)
	var left = Vector2(-1, 0)
	var right = Vector2(1, 0)
	while i < path.size():
		point_xy = pavement.world_to_map(utils.v3_to_v2(path[i]))
		if not is_walkable(point_xy + up):
			path[i] += Vector3(0, +WallAvoidance, 0)
		if not is_walkable(point_xy + down):
			path[i] += Vector3(0, -WallAvoidance, 0)
		if not is_walkable(point_xy + left):
			path[i] += Vector3(WallAvoidance, 0, 0)
		if not is_walkable(point_xy + right):
			path[i] += Vector3(-WallAvoidance, 0, 0)
		i += 1

	return path

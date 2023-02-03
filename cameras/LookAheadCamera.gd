extends "res://cameras/BasicCamera.gd"

export var moving_speed = 6

var utils = preload("res://scripts/Utils.gd").new()

func _ready():
	get_viewport().warp_mouse(player.position)

func _process(delta):
	global_position = lerp(global_position,
			utils.middle_point(
				player.position, get_global_mouse_position()),
			moving_speed * delta)


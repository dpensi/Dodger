extends Node

var direction = Vector2()
var mouse_position
var wheel_down 
var wheel_up
var points_to

func _ready():
	pass

func get_input():
	push_error("AbstractController.get_input(): not implemented")
extends Node

var direction = Vector2()
var wheel_down 
var wheel_up
var points_to

onready var character = get_parent()

func _ready():
	pass

func get_input(_delta):
	push_error("AbstractController.get_input(): not implemented")

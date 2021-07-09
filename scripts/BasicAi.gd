extends "res://scripts/AbstractController.gd"

func _ready():
	print("I'm here, waiting ...")


func get_input():
	direction.x = 0
	direction.y = 0
	points_to = Vector2(0,0)

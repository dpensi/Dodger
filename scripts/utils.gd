extends Node
class_name Utils

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

func _init():
	pass

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func Vector2ToString(vec: Vector2):
	return "(" + str(vec.x) + ":" + str(vec.y) + ")"
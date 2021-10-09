extends RigidBody2D

# the character who's holding the weapon
var holder
var item_id = "Wakizashi"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func set_holder(new_holder):
	holder = new_holder

extends Node


var direction = Vector2()
var mouse_position
var wheel_down 
var wheel_up


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
	
func get_input(viewport):
	direction.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	direction.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	
	mouse_position = viewport.get_mouse_position()
	wheel_down = Input.is_action_just_released("ui_zoom_in")
	wheel_up = Input.is_action_just_released("ui_zoom_out")

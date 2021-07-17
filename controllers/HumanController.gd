extends "res://controllers/AbstractController.gd"

var toggle_run = false

func think(_delta):
	if Input.is_action_just_pressed("ui_run"): toggle_run = not toggle_run

	direction.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	direction.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	 
	wheel_down = Input.is_action_just_released("ui_zoom_in")
	wheel_up = Input.is_action_just_released("ui_zoom_out")
	points_to = character.get_global_mouse_position()
	
func do():
	if toggle_run:
		character.run()
	else:
		character.walk()
	character.look_at(points_to)


	

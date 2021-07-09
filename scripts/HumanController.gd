extends "res://scripts/AbstractController.gd"

func get_input():
	direction.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	direction.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	 
	mouse_position = get_parent().get_viewport().get_mouse_position()
	wheel_down = Input.is_action_just_released("ui_zoom_in")
	wheel_up = Input.is_action_just_released("ui_zoom_out")
	points_to = get_parent().get_global_mouse_position()
	

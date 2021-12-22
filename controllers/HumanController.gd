extends "res://controllers/AbstractController.gd"

signal toggle_inventory

var toggle_run = false

# wheel_down is used by the camera to manage the zoom
var wheel_down 

# wheel_up is used by the camera to manage the zoom
var wheel_up

# input_enabled disables the all the input except 
# the ui_ inventory, useful because when the inventory
# front-end is open you don't want the character to
# respond to keyboard inputs
var input_enabled = true
 
func think(_delta):
	# menu
	if Input.is_action_just_pressed("ui_inventory"):
		emit_signal("toggle_inventory")
	
	if input_enabled:	
		# interact
		if Input.is_action_just_pressed("ui_action"):
			process_interaction()

		# attack
		if Input.is_action_just_pressed("ui_attack"):
			character.attack()
		
		# extract item
		if Input.is_action_just_pressed("ui_draw"):
			character.toggle_item()
				
		# movement
		if Input.is_action_just_pressed("ui_run"): toggle_run = not toggle_run
		direction.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
		direction.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
		
		# camera
		wheel_down = Input.is_action_pressed("ui_zoom_in")
		wheel_up = Input.is_action_pressed("ui_zoom_out")
		points_to = character.get_global_mouse_position()

func do():
	if not input_enabled: 
		character.wait()
		return
	
	if toggle_run:
		character.run()
	else:
		character.walk()
	
	character.look_at(points_to)


# proces the interaction with selected in-game object
# like open door, get item, talk to npc, etc...
func process_interaction():
	var nearby_areas = character.InteractionArea.get_overlapping_areas()
	var nearby_objects = []
	for na in nearby_areas:
		if na.name == "InteractionArea":
			nearby_objects.append(na.get_parent())

	for no in nearby_objects:
		if no.is_in_group("pickable"):
			character.pick_item(no)
			break
		else:
			push_error("HumanController.gd: Not implemented yet!")
	

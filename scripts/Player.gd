extends KinematicBody2D 

signal hit

export var ZoomSpeed = 0.2
export var MinZoom = 0.5
export var MaxZoom = 2.5
export var speed = 400  # How fast the player will move (pixels/sec).
export(PackedScene) var ControllerRef

onready var camera = get_node("Camera2D")
onready var Controller = ControllerRef.instance()
var screen_size  # Size of the game window.

func _ready():
	screen_size = get_viewport_rect().size
	
func _physics_process(delta):
	
	get_input() # sets input direction
	move(delta)
	animate()
	
func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false
	
func get_input():
	Controller.direction.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	Controller.direction.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")

	if Controller.direction.length() > 0:
		Controller.direction = Controller.direction.normalized() * speed
	
	Controller.mouse_position = get_viewport().get_mouse_position()
	Controller.wheel_down = Input.is_action_just_released("ui_zoom_in")
	Controller.wheel_up = Input.is_action_just_released("ui_zoom_out")
	
	
func move(delta):
	var collision = move_and_collide(
		(Controller.direction.normalized() * speed) * delta
	)
	if collision:
		print("I collided with ", collision.collider.name)
	point_at_cursor()
	zoom()


func zoom():
	if Controller.wheel_down: # zoom in 
		camera.zoom.x -= ZoomSpeed
		camera.zoom.y -= ZoomSpeed
	if Controller.wheel_up: # zoom out
		camera.zoom.x += ZoomSpeed
		camera.zoom.y += ZoomSpeed
	
	camera.zoom.x = clamp(camera.zoom.x, MinZoom, MaxZoom)
	camera.zoom.y = clamp(camera.zoom.y, MinZoom, MaxZoom)

		
		
func animate():
	$AnimatedSprite.animation = "walk"
	$AnimatedSprite.play()
	if Controller.direction.x == 0 and Controller.direction.y == 0:
		$AnimatedSprite.stop()

func point_at_cursor():
	var translation_vector = Controller.mouse_position - Vector2(get_viewport().size.x/2, get_viewport().size.y/2)
	rotation = (translation_vector).angle()


func _on_Player_body_entered(_body):
	hide()  # Player disappears after being hit.
	emit_signal("hit")
	$CollisionShape2D.set_deferred("disabled", true)

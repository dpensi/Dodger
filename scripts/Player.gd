extends Area2D 

signal hit

export var ZoomSpeed = 0.2
export var MinZoom = 0.5
export var MaxZoom = 2.5
export var speed = 400  # How fast the player will move (pixels/sec).

onready var camera = get_node("Camera2D")

var screen_size  # Size of the game window.
var direction= Vector2()
var mouse_position
var wheel_down 
var wheel_up

func _ready():
	screen_size = get_viewport_rect().size
	
func _process(delta):
	direction = Vector2()
	get_input() # sets input direction
	move(delta)
	animate()
	
func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false
	
func get_input():
	direction.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	direction.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")

	if direction.length() > 0:
		direction = direction.normalized() * speed
	
	mouse_position = get_viewport().get_mouse_position()
	wheel_down = Input.is_action_just_released("ui_zoom_in")
	wheel_up = Input.is_action_just_released("ui_zoom_out")
	
	
func move(delta):
	position += direction * delta
	point_at_cursor(mouse_position)
	zoom()


func zoom():
	if wheel_down: # zoom in 
		camera.zoom.x -= ZoomSpeed
		camera.zoom.y -= ZoomSpeed
	if wheel_up: # zoom out
		camera.zoom.x += ZoomSpeed
		camera.zoom.y += ZoomSpeed
	
	camera.zoom.x = clamp(camera.zoom.x, MinZoom, MaxZoom)
	camera.zoom.y = clamp(camera.zoom.y, MinZoom, MaxZoom)

		
		
func animate():
	$AnimatedSprite.animation = "walk"
	$AnimatedSprite.play()
	if direction.x == 0 and direction.y == 0:
		$AnimatedSprite.stop()

func point_at_cursor(mouse_position):
	var translation_vector = mouse_position - Vector2(get_viewport().size.x/2, get_viewport().size.y/2)
	rotation = (translation_vector).angle()


func _on_Player_body_entered(_body):
	hide()  # Player disappears after being hit.
	emit_signal("hit")
	$CollisionShape2D.set_deferred("disabled", true)

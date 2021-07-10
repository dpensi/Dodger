extends KinematicBody2D 

signal hit

export var ZoomSpeed = 0.2
export var MinZoom = 0.5
export var MaxZoom = 2.5
export var speed = 400  # How fast the player will move (pixels/sec).
export(PackedScene) var ControllerRef
export(PackedScene) var CameraRef

onready var Controller = ControllerRef.instance()

var screen_size  # Size of the game window.
var camera = null

func _ready():
	screen_size = get_viewport_rect().size
	add_child(Controller)
	if CameraRef != null:
		camera = CameraRef.instance() 
		camera.make_current()
		add_child(camera)
	
		
func _physics_process(delta):
	Controller.get_input(delta) # sets input direction
	move(delta)
	animate()
	
func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false
		
func move(delta):
	var collision = move_and_slide(
		(Controller.direction.normalized() * speed) * delta
	)
	if collision:
		pass
	#point_at_cursor()
	look_at(Controller.points_to)
	
	if camera != null:
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



func _on_Player_body_entered(_body):
	hide()  # Player disappears after being hit.
	emit_signal("hit")
	$CollisionShape2D.set_deferred("disabled", true)

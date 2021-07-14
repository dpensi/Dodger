extends KinematicBody2D 

export var WalkSpeed = 200
export var WalkAcceleration = 0.2
export var RunSpeed = 500
export var RunAcceleration = 0.3 
export(PackedScene) var ControllerRef
export(PackedScene) var CameraRef

onready var Controller = ControllerRef.instance()

var screen_size  # Size of the game window.
var camera = null
var velocity = Vector2.ZERO

func _ready():
	screen_size = get_viewport_rect().size
	add_child(Controller)
	if CameraRef != null:
		camera = CameraRef.instance() 
		camera.make_current()
		add_child(camera)
	
func _process(_delta):
	animate()	

func _physics_process(delta):
	Controller.think(delta) # sets input direction
	Controller.do()
	
func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false

func run():
	velocity = lerp(velocity, Controller.direction.normalized() * RunSpeed, RunAcceleration)
	velocity = move_and_slide(velocity)
	for i in get_slide_count():
		var _collision = get_slide_collision(i)
		#print("I ran into ", collision.collider.name)


func walk():
	velocity = lerp(velocity, Controller.direction.normalized() * WalkSpeed, WalkAcceleration)
	velocity = move_and_slide(velocity)
	for i in get_slide_count():
		var _collision = get_slide_collision(i)
		# print("I walked into ", collision.collider.name)

func wait():
	pass

func animate():
	$AnimatedSprite.animation = "walk"
	$AnimatedSprite.play()
	if Controller.direction.x == 0 and Controller.direction.y == 0:
		$AnimatedSprite.stop()

func _on_FieldOfView_body_entered(body):
	print("i can see ", body.name)

func _on_FieldOfView_body_exited(body):
	print("can't see ", body.name, " anymore")

# force collision detection during rotation
# func _physics_process(delta):
#     rotation += delta
#     move_and_collide(Vector2.ZERO)

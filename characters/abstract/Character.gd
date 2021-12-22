extends KinematicBody2D 

var utils = preload("res://scripts/Utils.gd").new()

export var WalkSpeed = 200
export var WalkAcceleration = 0.2
export var RunSpeed = 500
export var RunAcceleration = 0.3 
export var RotationSpeed = 0.3
export var HitPoints = 3 # negative value for instadeath
export(PackedScene) var ControllerRef
export(PackedScene) var CameraRef

onready var Controller = ControllerRef.instance()
onready var Inventory = get_node("Inventory")
onready var Equipped = get_node("Equipped")
onready var InteractionArea = get_node("InteractionArea")

enum States { ARMED, UNARMED }

var camera = null
var velocity = Vector2.ZERO
var current_state = States.UNARMED
var in_hand
var inventory_open = false

func _ready():
	add_child(Controller)
	if CameraRef != null:
		camera = CameraRef.instance() 
		camera.make_current()
		add_child(camera)
	
func _process(_delta):
	animate()	

func _physics_process(delta):
	Controller.think(delta) # controller plans
	Controller.do()			# controler executes character's actions
	
func get_last_collision():
	if get_slide_count() > 0:
		return get_slide_collision(get_slide_count()-1)
	
func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false

func run():
	velocity = lerp(velocity, Controller.direction.normalized() * RunSpeed, RunAcceleration)
	velocity = move_and_slide(velocity)

func walk():
	velocity = lerp(velocity, Controller.direction.normalized() * WalkSpeed, WalkAcceleration)
	velocity = move_and_slide(velocity)

func wait():
	velocity = lerp(velocity, Vector2.ZERO, WalkAcceleration) # stop gracefully
	velocity = move_and_slide(velocity)

# override default look_at to smooth rotation
func look_at(point):
	var final_rotation = rotation + get_angle_to(point)
	rotation = lerp(rotation, final_rotation, RotationSpeed)
	
func pick_item(item):
	Inventory.add_item(item)
	item.get_parent().remove_child(item)
	
func get_damage(source):
	HitPoints -= source.Damage
	if HitPoints < 0:
		die()
	
func toggle_item():
	match current_state:
		States.UNARMED:
			current_state = States.ARMED
			if Equipped.grid:
				var item = Equipped.get_item(Vector2.ZERO)
				if item:
					item.position = $RightHand.position
					item.z_index = 2
					add_child(item)
					in_hand = item
		States.ARMED:
			current_state = States.UNARMED
			if in_hand:
				in_hand.z_index = -1
				remove_child(in_hand)
				in_hand = null
			
func attack():
	if current_state == States.UNARMED:
		return
	
	if in_hand and in_hand.is_in_group("weapon"):
		in_hand.attack(null)
		
func die():
	# TODO make an animation
	queue_free()

func animate():
	var animation
	if utils.almost_gt(velocity.length(), WalkSpeed):
		animation = "run"
	else:
		animation = "walk"
	
	if current_state == States.ARMED:
		animation += "_hold"
	
	$AnimatedSprite.animation = animation
	
	if Vector2(-0.2,-0.2) < velocity and velocity <= Vector2(0.2,0.2):
		$AnimatedSprite.stop()
	else:
		$AnimatedSprite.play()

func _on_FieldOfView_body_entered(_body):
	# print("i can see ", body.name)
	pass

func _on_FieldOfView_body_exited(_body):
	# print("can't see ", body.name, " anymore")
	pass

# force collision detection during rotation
# func _physics_process(delta):
#     rotation += delta
#     move_and_collide(Vector2.ZERO)

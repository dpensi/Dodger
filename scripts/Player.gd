extends Area2D 

signal hit

export var speed = 400  # How fast the player will move (pixels/sec).
var screen_size  # Size of the game window.
var direction= Vector2()

func _ready():
	screen_size = get_viewport_rect().size
	
func _process(delta):
	direction = Vector2()
	# hide()
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
#
	if direction.length() > 0:
		direction = direction.normalized() * speed

	
func move(delta):
	position += direction * delta
	# position.x = clamp(position.x, 0, screen_size.x)
	# position.y = clamp(position.y, 0, screen_size.y)
		
		
func animate():
	$AnimatedSprite.animation = "walk"
	$AnimatedSprite.play()
	look_at(get_viewport().get_mouse_position())
	if direction.x == 0 and direction.y == 0:
		$AnimatedSprite.stop()

func _on_Player_body_entered(_body):
	hide()  # Player disappears after being hit.
	emit_signal("hit")
	$CollisionShape2D.set_deferred("disabled", true)

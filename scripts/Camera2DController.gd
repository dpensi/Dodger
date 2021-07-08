extends Camera2D


# Declare member variables here. Examples:
onready var player = get_parent()

# Called when the node enters the scene tree for the first time.
func _ready():
	position.x = player.position.x
	position.y = player.position.y


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position.x = delta * player.position.x
	position.y = delta * player.position.y

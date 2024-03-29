extends Camera2D


export var ZoomSpeed = 0.2
export var ZoomStep = 0.5
export var MinZoom = 0.5
export var MaxZoom = 2.5

onready var player = get_parent()

# Called when the node enters the scene tree for the first time.
func _ready():
	position.x = player.position.x
	position.y = player.position.y

func _process(_delta):
	zoom()

func zoom():
	if get_parent().Controller.wheel_down: # zoom in 
		zoom.x = lerp(zoom.x, zoom.x - ZoomStep, ZoomSpeed)
		zoom.y = lerp(zoom.y, zoom.y - ZoomStep, ZoomSpeed)
	if get_parent().Controller.wheel_up: # zoom out
		zoom.x = lerp(zoom.x, zoom.x + ZoomStep, ZoomSpeed)
		zoom.y = lerp(zoom.y, zoom.y + ZoomStep, ZoomSpeed)
	
	zoom.x = clamp(zoom.x, MinZoom, MaxZoom)
	zoom.y = clamp(zoom.y, MinZoom, MaxZoom)

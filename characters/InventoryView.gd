extends TextureRect

export(NodePath) var InventoryViewPortPath

onready var InventoryViewport : Viewport = get_node(InventoryViewPortPath)

func _ready():
	rect_size = get_viewport_rect().size
	
func _process(_delta):
	texture = InventoryViewport.get_texture()

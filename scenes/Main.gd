extends Node

func _ready():
	OS.set_window_size(Vector2(800, 600))
	$Player.Controller.connect("toggle_inventory", self, 
		"on_HumanController_toggle_inventory")
	
func on_HumanController_toggle_inventory():
	for bp in $InventoryLayer.get_children():
		bp.visible = not bp.visible
	
	$Player.Controller.input_enabled = not $Player.Controller.input_enabled

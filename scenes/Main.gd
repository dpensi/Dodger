extends Node

export(PackedScene) var BackgroundMusic

onready var backgroun_music = BackgroundMusic.instance()

func _ready():
	OS.set_window_size(Vector2(800, 600))
	$Player.Controller.connect("toggle_inventory", self, 
		"on_HumanController_toggle_inventory")
	
	play_background_music()
	
func play_background_music():
	var music_length = backgroun_music.stream.get_length()
	var music_randomizer = RandomNumberGenerator.new()
	music_randomizer.randomize()
	var needle_position = \
		music_randomizer.randi_range(0, music_length)
	backgroun_music.play(needle_position)
	add_child(backgroun_music)
	
func on_HumanController_toggle_inventory():
	for bp in $InventoryLayer.get_children():
		bp.visible = not bp.visible
	
	$Player.Controller.input_enabled = not $Player.Controller.input_enabled


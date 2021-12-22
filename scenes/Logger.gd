extends CanvasLayer

export(bool) var Enabled = true

const NL = '\n'

var utils = load("res://scripts/Utils.gd").new()
var monitored = []

onready var pointer = load("res://art/logger/EditorPositionPrevious.png")

func _ready():
	$Label.visible = Enabled

func _process(_delta):
	$Label.text = ""
	for mon in monitored:
		$Label.text += mon.message + " : " + \
			str(mon.object.get(mon.property)) + NL

func monitor_property(msg, obj, property_name):
	var mon = Monitored.new()
	mon.message = msg
	mon.object = obj
	mon.property = property_name
	monitored.append(mon)
	
func display_points(points):
	for child in get_tree().current_scene.get_children():
		if child.is_in_group("temp"):
			child.queue_free()
	for p in points:
		var sprite = Sprite.new()
		sprite.texture = pointer
		sprite.global_position = utils.v3_to_v2(p)
		sprite.add_to_group("temp")
		get_tree().current_scene.add_child(sprite)

class Monitored:
	var message
	var object
	var property


# get_tree().current_scene.get_node("Logger").display_points(current_path)

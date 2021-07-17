extends Node

export (PackedScene) var Mob
export (PackedScene) var Player
var score
var player

func _ready():
	OS.set_window_size(Vector2(640, 480))
	randomize()

func _on_Player_hit():
	game_over()
	
func game_over():
	$DeathSound.play()
	$ScoreTimer.stop()
	$MobTimer.stop()
	$HUD.show_game_over()
	get_tree().call_group("mobs", "queue_free")

func new_game():
	score = 0
	$StartTimer.start()
	$HUD.update_score(score)
	$HUD.show_message("Get Ready")

func _on_ScoreTimer_timeout():
	score += 1
	$HUD.update_score(score)

func _on_StartTimer_timeout():
	$ScoreTimer.start()

func _on_HUD_start_game():
	new_game()


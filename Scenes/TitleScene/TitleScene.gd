extends Node2D

func _on_play_button_pressed():
	ScoreManager.score = 0
	var game = load("res://Scenes/Game/Main.tscn").instantiate()
	get_window().add_child.call_deferred(game)
	queue_free()

func _on_quit_button_pressed():
	get_tree().quit()

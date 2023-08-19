extends Node

func _unhandled_input(event):
	if event.is_action_pressed("QUIT ABRUPTLY"):
		get_tree().quit()

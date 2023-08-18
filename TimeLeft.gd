extends RichTextLabel

@export var initial_time = 60
var current_time

signal game_ended

# Called when the node enters the scene tree for the first time.
func _ready():
	current_time = initial_time
	redraw_time()

func tick_down():
	current_time = maxi(0, current_time - 1)
	redraw_time()
	
	if current_time <= 0:
		game_ended.emit()
		$Timer.stop()

func redraw_time():
	text = "Time left: %d" % current_time

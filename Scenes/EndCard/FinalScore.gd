extends Label

func _ready():
	text = "Final Score: %d" % ScoreManager.score

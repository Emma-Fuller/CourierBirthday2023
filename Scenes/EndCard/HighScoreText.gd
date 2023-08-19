extends Label

const SAVE_FILE_PATH = "user://highscore.dat"
var highscore = 0

func _ready():
	var highscore = load_highscore()
	
	if ScoreManager.score > highscore:
		highscore = ScoreManager.score
		save_highscore(highscore)
		
	text = "High score: %d" % highscore

func load_highscore() -> int:
	var save_data = FileAccess.open(SAVE_FILE_PATH, FileAccess.READ)
	return save_data.get_64() if save_data else 0

func save_highscore(score: int):
	var save_data = FileAccess.open(SAVE_FILE_PATH, FileAccess.WRITE)
	save_data.store_64(score)
	save_data.flush()

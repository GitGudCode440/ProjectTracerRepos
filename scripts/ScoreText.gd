extends Label


var score : int
var scoreText : String = "SCORE: "

func _ready() -> void:
	score = 0
	text = scoreText + str(score)


func gain_score(_score : int):
	score += _score
	text = scoreText + str(score)

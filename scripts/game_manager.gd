extends Node

var score = 0

@onready var score_label: Label = $"../Player/ScoreLabel"


# 原作者是将 ScoreLabel 置于 GameManager 之下的，
# 而为了 ScoreLabel 能够跟随 Player，因此将前者作为后者子节点
func add_point():
	score += 1
	score_label.text = str(score) + " coins"

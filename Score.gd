extends CanvasLayer

func update_score():
	$Score.text = str(GameVariables.LAST_SCORE)
	$highscore.text = str(GameVariables.HIGH_SCORE)

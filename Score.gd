extends CanvasLayer

func update_score():
	$Score.text = str(GameVariables.LAST_SCORE)
	$highscore.text = str(GameVariables.HIGH_SCORE)


func _on_Button_pressed():
	OS.window_fullscreen = !OS.window_fullscreen

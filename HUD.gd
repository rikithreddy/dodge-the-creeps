extends CanvasLayer


signal start_game

func show_msg(text):
	$Message.text = text
	$Message.show()
	$MessageTimer.start()

func game_over():
	show_msg("Game Over")
	yield($MessageTimer, "timeout")
	$Start.show()
	$credits.show()
	$Message.text = "Dodge the\nCreeps"
	$Message.show()

func update_score(score, high_score):
	$Score.text = str(score)
	$highscore.text = str(high_score)

func _on_Start_pressed():
	$Start.hide()
	emit_signal("start_game")

func _on_MessageTimer_timeout():
	$Message.hide()

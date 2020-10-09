extends CanvasLayer

signal start_game

func show_msg(text):
	$Message.text = text
	$Message.show()
	$MessageTimer.start()

func game_over():
	show_msg("Game Over")
	yield($MessageTimer, "timeout")

func _on_Start_pressed():
	emit_signal("start_game")

func _on_MessageTimer_timeout():
	$Message.hide()

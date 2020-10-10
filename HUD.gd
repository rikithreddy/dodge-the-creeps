extends CanvasLayer

func show_msg(text):
	$Message.text = text
	$Message.show()
	$MessageTimer.start()

func game_over():
	show_msg("Annihilated")
	yield($MessageTimer, "timeout")

func _on_MessageTimer_timeout():
	$Message.hide()

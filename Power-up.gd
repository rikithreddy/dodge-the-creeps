extends Area2D

signal power_up


func _on_Powerup_area_entered(area):
	emit_signal("power_up")	
	queue_free()

func _process(delta):
	position.y += 100 * delta

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()

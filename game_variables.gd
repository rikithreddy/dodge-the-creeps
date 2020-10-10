extends Node

var LAST_SCORE = 0
var HIGH_SCORE = 0

var SCREEN_DIMENSIONS = Vector2(480,720)

func _process(delta):
	if Input.is_action_just_pressed("ui_cancel"):
		OS.window_fullscreen = false

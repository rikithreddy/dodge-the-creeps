extends Node2D

func _enter_tree():
	$Score.update_score()

func _on_HUD_start_game():
	get_tree().change_scene("res://main.tscn")

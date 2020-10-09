extends Node2D

const FILE_NAME = "user://game-data.json"
export (PackedScene) var Mob

var colors = [
	Color("#41658A"), # queen blue 
	Color("#35657B"), # ash grey
	Color("#3E5641"), # hunter green
	Color("#407076"), #Ming
	]

func new_game():
	$Background/ColorRect.set_frame_color(colors[randi()% len(colors)])	
	$HUD/Start.hide()
	$BGM.play()
	$HUD/credits.hide()
	GameVariables.LAST_SCORE = 0
	$Score.update_score()	
	$Player.start($start_position.position)
	$StartTimer.start()
	$HUD.show_msg("Get Ready")
	
func _ready():
	randomize()
	new_game()

func set_background_color():
	$Background/ColorRect.set_frame_color(colors[randi()% len(colors)])
	pass
	
func _on_ScoreTimer_timeout():
	GameVariables.LAST_SCORE += 1
	if GameVariables.HIGH_SCORE < GameVariables.LAST_SCORE:
		GameVariables.HIGH_SCORE = GameVariables.LAST_SCORE 
	if GameVariables.LAST_SCORE % 3 == 0:
		set_background_color()
	$Score.update_score()


func _on_MobTimer_timeout():
	$Path2D/PathFollow2D.set_offset(randi())
	var mob = Mob.instance()
	add_child(mob)
	var direction = $Path2D/PathFollow2D.rotation + PI / 2
	direction += rand_range(-PI/4, PI/4)
	mob.rotation = direction
	mob.global_position = $Path2D/PathFollow2D.global_position
	mob.set_linear_velocity(Vector2(rand_range(mob.MIN_SPEED, mob.MAX_SPEED), 0).rotated(direction))
  
func _on_StartTimer_timeout():
	$ScoreTimer.start()
	$MobTimer.start()

func game_over():
	$BGM.stop()
	$ScoreTimer.stop()
	$MobTimer.stop()
	$game_over.play()
	$HUD.game_over()
	$GameOver.start()

func _on_GameOver_timeout():
	get_tree().change_scene("res://Menu.tscn")
	

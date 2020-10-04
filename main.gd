extends Node2D

const FILE_NAME = "user://game-data.json"
export (PackedScene) var Mob
var score = 0
var high_score = 0

func new_game():
	$BGM.play()
	$HUD/credits.hide()
	score = 0
	$HUD.update_score(score, high_score)	
	$Player.start($start_position.position)
	$StartTimer.start()
	$HUD.show_msg("Get Ready")
	
func _ready():
	randomize()

func _on_ScoreTimer_timeout():
	score += 1
	if high_score < score:
		high_score = score
	$HUD.update_score(score, high_score)


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
	$HUD.game_over()
	$ScoreTimer.stop()
	$MobTimer.stop()
	$game_over.play()
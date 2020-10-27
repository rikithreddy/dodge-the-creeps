extends Node2D

const FILE_NAME = "user://game-data.json"
export (PackedScene) var Mob

var PowerUp = preload("res://Power-up.tscn")

onready var Display = $Background/background


var colors = [
	Color("#41658A"), # queen blue 
	Color("#35657B"), # ash grey
	Color("#3E5641"), # hunter green
	Color("#407076"), #Ming
	Color("#4E937A"),
	Color("#C7F2A7"),
	Color("#355070"),
	Color("#EAAC8B"),
	Color("#6D597A"),
	Color("#AFB3F7"),
	]

func new_game():
	$Background/ColorRect.set_frame_color(colors[randi()% len(colors)])	
	$BGM.play()
	$HUD/credits.hide()
	GameVariables.LAST_SCORE = 0
	$Score.update_score()	
	$Player.start($start_position.position)
	$StartTimer.start()
	$HUD.show_msg("Survive")
	
func _ready():
	randomize()
	new_game()

func set_background_color():
	$Background/ColorRect.set_frame_color(colors[randi()% len(colors)])
	
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
	var x = min(mob.MIN_SPEED + GameVariables.LAST_SCORE * 5, 350)
	var y = min(mob.MAX_SPEED + GameVariables.LAST_SCORE * 5, 500)
	mob.set_linear_velocity(Vector2(rand_range(x, y), 0).rotated(direction))
  
func _on_StartTimer_timeout():
	$ScoreTimer.start()
	$MobTimer.start()

func _screen_shake():
	var rand = Vector2()
	rand.x = rand_range(-10, 10)
	rand.y = rand_range(-10, 10)
	$ScreenShake.interpolate_property(
					$Score,
					"offset",
					$Score.offset, 
					rand,
					$ScreenShake/Frequency.wait_time,
					$ScreenShake.TRANS_SINE,
					$ScreenShake.EASE_IN_OUT
					)
	$ScreenShake.interpolate_property(
					$HUD,
					"offset",
					$HUD.offset, 
					rand,
					$ScreenShake/Frequency.wait_time,
					$ScreenShake.TRANS_SINE,
					$ScreenShake.EASE_IN_OUT
					)

	$ScreenShake.start()

func _start_screen_shake():
	$ScreenShake/TotalTime.start()
	$ScreenShake/Frequency.start()	
	_screen_shake()
	
func game_over():
	_start_screen_shake()
	$BGM.stop()
	$ScoreTimer.stop()
	$MobTimer.stop()
	$game_over.play()
	$HUD.game_over()
	$GameOver.start()
	

func _on_GameOver_timeout():
	var error = get_tree().change_scene("res://Menu.tscn")
	if error:
		print("Something went wrong")


func _on_Frequency_timeout():
	_screen_shake()


func _on_TotalTime_timeout():
	$ScreenShake/Frequency.stop()

	$ScreenShake.interpolate_property($Score, "offset",
						$Score.offset, 
						Vector2(),
						$ScreenShake/Frequency.wait_time,
						$ScreenShake.TRANS_SINE,
						$ScreenShake.EASE_IN_OUT
						)
	$ScreenShake.interpolate_property($HUD, "offset",
					$HUD.offset, 
					Vector2(),
					$ScreenShake/Frequency.wait_time,
					$ScreenShake.TRANS_SINE,
					$ScreenShake.EASE_IN_OUT
					)
	$ScreenShake.start()


func _on_Powerup_power_up():
	$PowerUpAudio.play()
	$Player.scale.x /= 2
	$Player.scale.y /= 2
	$Player/Power.emitting = true
	$PowerDuration.start()

func _on_PowerUpTimer_timeout():
	var pwr = PowerUp.instance()
	add_child(pwr)
	pwr.position.x = rand_range(50, GameVariables.SCREEN_DIMENSIONS.x - 50)
	pwr.position.y = 96
	pwr.connect("power_up", self, "_on_Powerup_power_up")


func _on_PowerDuration_timeout():
	$PowerUpAudio.stop()
	$Player.scale.x *= 2
	$Player.scale.y *= 2
	$Player/Power.emitting = false
	$PowerUpTimer.wait_time = rand_range(2, 4)
	$PowerUpTimer.start()


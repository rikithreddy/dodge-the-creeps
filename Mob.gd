extends RigidBody2D

var MIN_SPEED = 300
var MAX_SPEED = 500
const TYPES = ["fly", "swim", "walk"]
var type : String

func _ready():
	type = TYPES[randi() % 3]
	$AnimatedSprite.play(type)
	
func _on_VisibilityNotifier2D_screen_exited():
	queue_free()

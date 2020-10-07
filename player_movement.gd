class_name PlayerMovement

var SPEED = 400
var screen_size: Vector2 = OS.window_size

func _ready():
	pass # Replace with function body.


func movement(position, direction, delta):
	if direction.length() > 0:
		position += direction.normalized() * SPEED * delta
		position.x = clamp(position.x, 0, screen_size.x)
		position.y = clamp(position.y, 128, screen_size.y)

	return position